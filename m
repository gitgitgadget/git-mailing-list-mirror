From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: Some information that git diff saves and that git status does
 not
Date: Tue, 09 Mar 2010 07:58:11 +0100
Message-ID: <4B95F183.7000708@gmail.com>
References: <loom.20100308T111146-322@post.gmane.org> <7vpr3emr3s.fsf@alter.siamese.dyndns.org> <4B95EC43.2040705@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 09 13:30:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoyVn-0001Do-Ln
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:26:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545Ab0CIG6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 01:58:20 -0500
Received: from mail-bw0-f222.google.com ([209.85.218.222]:58969 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873Ab0CIG6T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 01:58:19 -0500
Received: by bwz22 with SMTP id 22so269197bwz.28
        for <git@vger.kernel.org>; Mon, 08 Mar 2010 22:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=kjtkAkDH4zxtQ9KwTPEDOb4XSxVpiM8EL9TThBtQm/Q=;
        b=AgAnlOHlui1SRN2PbkBpr3ulEhWNNC2IWtve8qNVuQxTQDs5GY8qeTvvuoeQQCIsSV
         pSi0aJl/+3gnbtoOOytDlefPMDftEvVKoCOFLPEBSrGeXFp+Ls84LexnAyt7ENNS50bH
         7gY2+2mKlZfXhLA/hYagD+HbIYxm43LqjEx+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=umbiUJKwFkhhqXDbPXMzuMIXFRDxgU0bBzSVILz9ecUlXgmRDaiw1N2tgnIFiPBib4
         6KWdRGgU+swE95UyKe8qIyccNhUhenSAdswzinpsSTlJoov57u6BCoi1L33/mISVtloO
         00iVVjWnJasRQBNh3mF0BZtgaC4wxo/GhbYnk=
Received: by 10.204.130.72 with SMTP id r8mr983817bks.25.1268117897127;
        Mon, 08 Mar 2010 22:58:17 -0800 (PST)
Received: from [217.202.59.61] ([217.202.59.61])
        by mx.google.com with ESMTPS id 14sm2159637bwz.10.2010.03.08.22.58.14
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 08 Mar 2010 22:58:16 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <4B95EC43.2040705@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141805>

Johannes Sixt wrote:
> Junio C Hamano schrieb:
>   
>> I didn't fully read what you wrote but after you copy a repository from
>> one to another outside git (be it done with unison or rsync), you should
>> run "update-index --refresh".
>>     
>
> And the reason for this is that git also looks at the inode numbers, and I
> guess that unison does not go as far as to preserve them between machines...
>
> -- Hannes
>
>   
Thanks for all the info...  and sorry for the too verbose post at the 
beginning.

I actually did not know about the

update-index --refresh

but now I have the relevant information its name sounds obvious.  And I 
suspected something like inode data entering the game.

As a matter of fact, I was obtaining the same effect with git diff.

What was appearing to me as a quirk is that:

1) If you do not refresh the index, git works perfectly all the same.  
For instance, git status shows the right info. Only it is not that fast 
anymore, since everytime it needs to runs the filters on all the files.
2) git status does not refresh the index, while other commands like git 
diff do.

I was wandering whether git status could refresh the index 
automatically, at least about those files on which expensive actions, 
such as running filters had already been performed anyway.

Sergio

Sergio
