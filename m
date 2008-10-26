From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Sun, 26 Oct 2008 21:54:53 +0200
Message-ID: <94a0d4530810261254m3668f02ek461fd220805f9b92@mail.gmail.com>
References: <ge0rla$mce$1@ger.gmane.org> <m3r663h276.fsf@localhost.localdomain>
	 <94a0d4530810260857u7c0cb122g8147b9484108f539@mail.gmail.com>
	 <200810262007.30148.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mercurial@selenic.com
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 20:56:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuBia-0005bs-Aq
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 20:56:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726AbYJZTyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 15:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753363AbYJZTyy
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 15:54:54 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:4372 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbYJZTyx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 15:54:53 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1785920rvb.1
        for <git@vger.kernel.org>; Sun, 26 Oct 2008 12:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=KsF7+NbfTQuWlhOMlC2O9d85UwOfzDf2NqYHvVGu/xY=;
        b=rv0xYzBPcXjR5wJywZRIHeNYaFVWC/mHNa3xbAihRadj0xLve3kC5y4CwkIVeERdf2
         jDolh/KrwPsE+Ydq4ERycCxQZYPDUouiyr5QGsvgz+ckZMlTZSqtVLWAf/T/xY4Wjhyg
         uwXo+gwR1CRzGpmiRK4nRGo/76FwNf8nF3zvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=rnFWQShQCEzIZsdwTz+A3II/iVpw1Ny+ZoEPK/snFi+30OZuR7qi0a1g9m7Ct0Ebv6
         Rb6sfiRsbhREy3e0NuHPN6m/n6NFhDUVyZiCMXDZypKHCyjyHVmJcOikb3c46ZKt7Coe
         PD9Wt3v1Ml9wBhVCYQEJly+eLBTY/MNUsbXjw=
Received: by 10.140.147.5 with SMTP id u5mr2736925rvd.274.1225050893086;
        Sun, 26 Oct 2008 12:54:53 -0700 (PDT)
Received: by 10.140.171.5 with HTTP; Sun, 26 Oct 2008 12:54:53 -0700 (PDT)
In-Reply-To: <200810262007.30148.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99182>

On Sun, Oct 26, 2008 at 9:07 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> I'm not sure if Mercurial mailing list is not subscribe only. Git isn't.
>
> On Sun, 26 Sep 2008, Felipe Contreras wrote:
>> On Sun, Oct 26, 2008 at 4:15 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> > [Cc: gmane.comp.version-control.git,
>> >     gmane.comp.version-control.mercurial.general]
>
>> > 3. Repository design and performance.
>
>> >   Git and Mercurial have similar performance, although it is thought
>> >   that due to design Mercurial has faster patch applying and is
>> >   optimized for cold cache case, while Git has faster merging and is
>> >   optimized for warm cache case.
>> >
>> >   Mercurial may have (or had) problems with larger binary files, from
>> >   what I have heard.
>>
>> The fact that hg is changeset based means that certain operations are
>> slower, like checkout a specific commit. In hg my bet is you would
>> need to gather a bunch of changesets while in git the operation is
>> done in a single step.
>
> Actually from what I have read Mercurial stores current version
> (snapshot) from time to time, so time to resolve specific commit is
> limited.  Also if you have packed your Git repository (good idea not
> only to limit size, but also for performance (I/O performance)), then
> resolving specific commit also might require some delta resolution
> (by default delta chain length is limited to 50, see pack.depth).

Ah, ok, good to know.

>> It also means that bare clones are not possible in hg, or at least
>> very complicated.
>
> I think it is things like .hgtags which make bare clones (without
> working directory) to be hard or even impossible in Mercurial.

Oops, I meant shallow clones (git clone --depth=1).

-- 
Felipe Contreras
