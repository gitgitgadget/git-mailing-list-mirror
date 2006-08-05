From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Git files data formats documentation
Date: Sat, 05 Aug 2006 10:31:09 -0700
Message-ID: <44D4D5DD.8070908@gmail.com>
References: <44D42F0D.3040707@gmail.com> <20060805162233.GA19909@spearce.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Aug 05 19:31:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9PzY-0003KC-R7
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 19:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422632AbWHERbN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 13:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422638AbWHERbN
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 13:31:13 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:52520 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422632AbWHERbN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 13:31:13 -0400
Received: by py-out-1112.google.com with SMTP id z74so497652pyg
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 10:31:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=fsodBVZEfhidV7L1sZxKXveJrs2Va7Pn6V4PsC7ySXBPdZF4wyM4J0NE0gKMzYmLdvnu3lfSQVidxRGTA64uTvbfPBbl3ipUYUFi07+DSvfFr4X6EP7krKGsrjPFbhrmoH7aJpNP9GsPXSLRab444mNseUcnKwdMF16b610BpEU=
Received: by 10.35.113.12 with SMTP id q12mr7771651pym;
        Sat, 05 Aug 2006 10:31:11 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.32.187.210])
        by mx.gmail.com with ESMTP id w28sm2062741pyc.2006.08.05.10.31.10;
        Sat, 05 Aug 2006 10:31:11 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060411)
X-Accept-Language: en-us, en
To: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
In-Reply-To: <20060805162233.GA19909@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24922>

Shawn Pearce wrote:
> A Large Angry SCM <gitzilla@gmail.com> wrote:
>> This information may be useful for reading and writing the various Git 
>> files.
> [snip]
>> 	#	/* -  -  -  -  -  -  -  -  -  -  -  - *\
>> 	#	 | This reflects version 3 pack files |
>> 	#	\* -  -  -  -  -  -  -  -  -  -  -  - */
> [snip]
>> 	#	/* -  -  -  -  -  -  -  -  -  -  -  - *\
>> 	#	 | This reflects version 2 pack files |
>> 	#	\* -  -  -  -  -  -  -  -  -  -  -  - */
> 
> Thanks for taking the time to write these out.  The pack delta
> formats were particularly helpful as it caused me to go back
> and look at the unpacking code in jgit.
> 
> Apparently I wasn't handling the version 2 pack file correctly as I
> didn't support copy-from-result; I had an infinite loop if the base
> didn't decompress in one read (never happen right now, but could
> in the future); and apparently my insert opcode implementation was
> causing an infinite loop.  Nasty bugs.  I need to get more unit
> tests written apparently.  :-)

Keep in mind that the git-core code for reading version 2 or version 3 
pack files does _not_ handle copy-from-result correctly.
