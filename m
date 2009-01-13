From: "Emily Ren" <lingyan.ren@gmail.com>
Subject: Re: How to pull remote branch with specified commit id?
Date: Tue, 13 Jan 2009 21:15:03 +0800
Message-ID: <856bfe0e0901130515o5739bcbft1927f42a2dd85ad3@mail.gmail.com>
References: <856bfe0e0901130108q3af1345cy31751dd09e030c96@mail.gmail.com>
	 <496C5BE3.2040206@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailinglist" <git@vger.kernel.org>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Jan 13 14:17:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMj8D-0006eJ-3r
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 14:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756888AbZAMNPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 08:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756280AbZAMNPF
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 08:15:05 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:48402 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756324AbZAMNPE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 08:15:04 -0500
Received: by yx-out-2324.google.com with SMTP id 8so3614225yxm.1
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 05:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=a2gz7tg8RTKSvjhVREoLqHIqS9XQrTiYojKNvbSg33E=;
        b=tsFl3wyGJCW3OkpuTjaCrbsZAyqAJlxnyVt4aumbg8VQJtsCiO+Asvw5yVygkioc4O
         nCBuZ+4dg9LkQ3VbqsLqJ2YNkbBIePa4I7GsPH5s23P5MK1vhSgbcZzFsqlvybXZ+3Zm
         530/WnrDAVIePn4G2iVueN+8eyE7FdYmPAF/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=a4BjkoXAn0qltF/MNlpJWFMUDLucLRIb8+HfEpWUzUMESIzNNMbx9TLNLU1+H18JdB
         iE/SEjd/CdUdXZ8AkCU+83jkiCiQQvfWgad4IdTX0xVNPs8t+e+K2tVn7x9s17aSd9PK
         MWSecrZ+N51878by7hht0sd9MKdZ23RUHkh20=
Received: by 10.151.155.10 with SMTP id h10mr254303ybo.97.1231852503245;
        Tue, 13 Jan 2009 05:15:03 -0800 (PST)
Received: by 10.151.107.12 with HTTP; Tue, 13 Jan 2009 05:15:03 -0800 (PST)
In-Reply-To: <496C5BE3.2040206@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105495>

Andreas,

I tried your method, it works. Thank you very much !

Emily

On Tue, Jan 13, 2009 at 5:16 PM, Andreas Ericsson <ae@op5.se> wrote:
> Emily Ren wrote:
>>
>> Git experts,
>>
>> I want to pull remote branch with specified commit id, how to do it?
>>
>> Below command can get remote branch
>> $git pull remote refs/heads/$branch_name
>>
>> Below command doesn't work
>> $git pull remote objects/$commit_id
>>
>
> You need to fetch it first, and then merge the commit you want. The
> tools operating the fetching protocol only use refs, so if you want
> to fetch (or pull) a specific version that has neither a tag nor a
> branch head pointing to it, you'll have to write a new tool for that.
>
> The end-result of the following command will be, barring side-effects
> in the remote-tracking branches, identical to what you're trying to
> do though:
> git fetch remote && git merge $commit_id
>
> --
> Andreas Ericsson                   andreas.ericsson@op5.se
> OP5 AB                             www.op5.se
> Tel: +46 8-230225                  Fax: +46 8-230231
>
