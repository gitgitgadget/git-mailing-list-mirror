From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: gitignore design
Date: Fri, 29 Jul 2011 17:44:41 +0100
Organization: OPDS
Message-ID: <295478CF936A4310941CE2001892A2DA@PhilipOakley>
References: <1311934832699-6632987.post@n2.nabble.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "llucianf" <llucianf@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 29 18:44:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmqB5-0003OY-K7
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 18:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480Ab1G2Qom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 12:44:42 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:59119 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751350Ab1G2Qom (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2011 12:44:42 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Au4AAK/iMk5cHKoL/2dsb2JhbAArCQEBBAEIAQE0FQUIAQEYEAYBAQQFAwEDEQMBAQEKMRQBAQQMEAIHCBYIBwEIDgwCAQIDAQ0EiX6NcI9XeIh8AgK/KoViXwSHK5U5AYZ5
X-IronPort-AV: E=Sophos;i="4.67,288,1309734000"; 
   d="scan'208";a="360716396"
Received: from host-92-28-170-11.as13285.net (HELO PhilipOakley) ([92.28.170.11])
  by out1.ip01ir2.opaltelecom.net with SMTP; 29 Jul 2011 17:44:39 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6109
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178157>

The answer is that you can use
   git add --force <filename>
to force git to take a copy of the current version of that file and place it 
in the staging area, despite it being in the ignore list.

 Being *in* the staging area means that that specific version will be copied 
into each commit until you ask git to remove that copy (with git rm 
<filename> from the staging area, or update that copy, or whatever.

This depends on how (i.e. the options) you add files before a commit, or do 
the commit itself, etc. For example the 'git add -A .' option will notice 
all the changes, including any updates to your <filename> (which may not be 
what you want).

Git is flexible enough to do what you need. It can be hard to see the effect 
of all the options especially if someone has shown you a 'magic' command, 
but hasn't fully explained the consequences. Many things are only obvious in 
retrospect.

Philip Oakley
Scotland
----- Original Message ----- 
From: "llucianf" <llucianf@gmail.com>
To: <git@vger.kernel.org>
Sent: Friday, July 29, 2011 11:20 AM
Subject: gitignore design


> why gitignore doesnt simply work like in cvs where if you put something in
> the ignore file, those stuff are simply ignored from that point without
> having to remove them from repo?
>
>
> --
> View this message in context: 
> http://git.661346.n2.nabble.com/gitignore-design-tp6632987p6632987.html
> Sent from the git mailing list archive at Nabble.com.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> ______________________________________________________________________
> This email has been scanned by the MessageLabs Email Security System.
> For more information please visit http://www.messagelabs.com/email
> ______________________________________________________________________
>
>
> -----
> No virus found in this message.
> Checked by AVG - www.avg.com
> Version: 10.0.1390 / Virus Database: 1518/3793 - Release Date: 07/28/11
> 
