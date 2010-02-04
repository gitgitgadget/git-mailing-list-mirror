From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Dealing with many many git repos in a /home directory
Date: Thu, 4 Feb 2010 10:57:55 +0100
Message-ID: <81b0412b1002040157r7af2a587y9cfc7189fc8ad632@mail.gmail.com>
References: <9b18b3111002040029x1c7de0afw4a5ef883588f7a18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 10:58:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcyTT-0003bH-HO
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 10:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758165Ab0BDJ6J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2010 04:58:09 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:63927 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758149Ab0BDJ55 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2010 04:57:57 -0500
Received: by bwz19 with SMTP id 19so110341bwz.28
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 01:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZdwV7CC4hi3C0j6Zx+fRDDsIaBiw2DpiS/AuyN54gE4=;
        b=ZP284PSIMu6+XHebgNaDD2Kc/OSBJdzGrZCJNtcxo5AmjdgcN9fL2Cf4qWtEnNOjQZ
         2jaK7xO21n4yKu9cnLk8uqTZIbWXlO6kCtF3FW9VENgq4EnIeRiIwRVgNq0bosLVKQzs
         ur6TAbS902ETsJ2iwIMu0Y3kqX+9XCoesHf+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mIuRkAVUr1+m+733GrX5Ki5Zesb+/Ku8eUGBPWOmuhdgJhOwx2Ai57ZpSePL+0HDQS
         zSblDAMTbtkok+gIiXEJBcdCqvXMMml3CD7FP0/kruehE23tPknYHWedSpgfciOVRXkF
         E2jj0ndp0LkhxJsvFIuy5FRGjYKFRsRl6+bUk=
Received: by 10.204.140.18 with SMTP id g18mr550906bku.47.1265277475797; Thu, 
	04 Feb 2010 01:57:55 -0800 (PST)
In-Reply-To: <9b18b3111002040029x1c7de0afw4a5ef883588f7a18@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138961>

On Thu, Feb 4, 2010 at 09:29, demerphq <demerphq@gmail.com> wrote:
> Would i be correct in thinking that if i have to repos with an
> equivalent =C2=A0.git/objects/../..... file in them that the files ar=
e
> necessarily identical and one can be replaced by a hardlink to the
> other?

Yes, but you probably wont save as much as you'd like: think about the =
users
who *do* repack their repositories. The .pack files will be all differe=
nt.
