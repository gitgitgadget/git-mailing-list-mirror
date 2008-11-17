From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: fixes to gitweb feature check code
Date: Mon, 17 Nov 2008 07:10:49 +0100
Message-ID: <cb7bb73a0811162210iadb7511rc3474272c8e60c59@mail.gmail.com>
References: <1226759165-6894-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200811170202.27893.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 07:12:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1xLf-0003eJ-1L
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 07:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbYKQGKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 01:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752120AbYKQGKv
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 01:10:51 -0500
Received: from qb-out-0506.google.com ([72.14.204.224]:55697 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbYKQGKu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 01:10:50 -0500
Received: by qb-out-0506.google.com with SMTP id f11so2240707qba.17
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 22:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=JuH1c+86WvxPy8K8ctUibGAP2hztB7yspELNMG/6dZ4=;
        b=RmgHZtMWTk8Y2lCDAZYb+NmZH48Ps2wVv6e/PawSuFK+RUdcgKznZgtT6RFaRwJK7V
         YcWq5L74jhrzLjyGN3hI9tqlDbuwJzXZYDsH3ianWacEH5YyYo2uvkZWekD04GWGACig
         KCZivfsE/XlyCZHU12JmgDNuz0N8hV7WhyrT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZBFzmnr6P95LulmHyhYWjwqSFIAD7ga5OtW1IyjnY9jft1udgStjtzQz7cxE309fTC
         qNb2ECczivaGmUZSMKOZaVzkArnNMGqYy1i3yFCl6genLLPcyKOryeiKyMLQ2oChTzYx
         HOe8xxaYusEJ7BvsZCjgiNYfhgrMCDdxx/oEY=
Received: by 10.210.81.10 with SMTP id e10mr3620216ebb.122.1226902249106;
        Sun, 16 Nov 2008 22:10:49 -0800 (PST)
Received: by 10.210.132.16 with HTTP; Sun, 16 Nov 2008 22:10:49 -0800 (PST)
In-Reply-To: <200811170202.27893.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101195>

On Mon, Nov 17, 2008 at 2:02 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Sat, 15 Nov 2008, Giuseppe Bilotta wrote:
>
>> The gitweb_check_feature routine was being used for two different
>> purposes: retrieving the actual feature value (such as the list of
>> snapshot formats or the list of additional actions), and to check if a
>> feature was enabled.
>>
>> For the latter use, since all features return an array, it led to either
>> clumsy code or subtle bugs, with disabled features appearing enabled
>> because (0) evaluates to 1.
>>
>> We fix these bugs, and simplify the code, by separating feature (list)
>> value retrieval (gitweb_get_feature) from boolean feature check (i.e.
>> retrieving the first/only item in the feature value list). Usage of
>> gitweb_check_feature across gitweb is replaced by the appropriate call
>> wherever needed.
>> ---
>
> First, you forgot the signoff, but you have addressed that already.
>
>
> Second, I thought at first that it would be good for the patch to also
> simplify %feature hash, using "'default' => 1" instead of current bit
> convoluted "'default' => [1]", at the cost of bit more code for
> defensive programming.  But now I think that if it is to be done,
> it should be put as separate patch.

Is this an ACK? 8-D

-- 
Giuseppe "Oblomov" Bilotta
