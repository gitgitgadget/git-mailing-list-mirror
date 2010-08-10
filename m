From: Joshua Juran <jjuran@gmail.com>
Subject: Re: [PATCH] More readable 'Not a git repository' messages
Date: Tue, 10 Aug 2010 15:34:17 -0700
Message-ID: <D944E855-0ECF-41AF-ACD4-8ED8EABCBC1D@gmail.com>
References: <i3pdkj$hut$1@dough.gmane.org> <20100810155240.GA5116@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 00:34:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OixOr-0006tH-Lr
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 00:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755750Ab0HJWeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 18:34:21 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:43362 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab0HJWeT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 18:34:19 -0400
Received: by pxi10 with SMTP id 10so255813pxi.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 15:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=tXFNNZ/DrzOBuDAP4o2vWPUhueaRpPRT/FGSXpMomD8=;
        b=dEjWKeTNDDEvNTBclAV0iQbDP3tp9BQ5kqr0kQW2xhAF2pqu7W5Psal4k/bnBCqTIf
         7p4dWzslgfwYKZas7vgf9Z0L0IUJfYZhAd+gvyjWrMYXsbEeCbSUr1ymz6A9ACPgb6Z0
         l+iJSsU7OFNX+B/K7zX4wE8K31FvXCb/UfUQk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=W2TmzNJJxZPpNlA1e7+gJwnQ4+puQTkV00aeEzWbzEvCtKbZboYutv+gfv9J/Tes2e
         r30pI55AppoRmX3LF95rk2llzbISRnvO8dxmoU1EQxAjZuTG73qJhCnSUrmS8dIsOUYu
         LcahXxSwVBJsp5c9sXbZm6aIe8zU/dlGF0nU8=
Received: by 10.142.169.19 with SMTP id r19mr5243654wfe.177.1281479658975;
        Tue, 10 Aug 2010 15:34:18 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id v38sm8329814wfh.12.2010.08.10.15.34.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 15:34:17 -0700 (PDT)
In-Reply-To: <20100810155240.GA5116@localhost.localdomain>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153169>

On Aug 10, 2010, at 8:52 AM, Jared Hance wrote:

> On Mon, Aug 09, 2010 at 07:24:35PM +0200, Ralf Ebert wrote:
>> old: Not a git repository (or any of the parent directories): .git
>> new: Not in a git repository: /home/bob/somefolder
>
> Don't we lose information here? Perhaps print the value of
> DEFAULT_GIT_DIR_ENVIRONMENT.
>
>> old: Not a git repository (or any parent up to mount parent /home/ 
>> bob)
>> old: Stopping at filesystem boundary
>> (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).
>> new: Not in a git repository: /home/bob/somefolder
>> new: (stopped searching at /home because
>> GIT_DISCOVERY_ACROSS_FILESYSTEM is not set)
>
> This certainly looks good, but some people might not realize /home is
> a filesystem boundary (perhaps those who had someone else set up their
> system and don't know their partition setup. I suggest:
>
> (stopped searching at the filesystem boundary, /home, because
> GIT_DISCOVERY_ACROSS_FILESYSTEM is not set)

If the search for .git stops at /home or $HOME, why not say nothing at  
all?  If you've turned /home (or /) into a Git repo, then either you  
know what you're doing or you deserve as much pain as possible.  (I  
haven't decided which.)

Josh
