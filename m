From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] send-email: allow use of basic email list in --cc --to
 and --bcc
Date: Tue, 18 Jun 2013 16:25:23 +0530
Message-ID: <CALkWK0=rTk2Jx7x_sx1BcwFXWVa4TR=gp2+1Sx3COdMeO_2iZw@mail.gmail.com>
References: <1371549079-19291-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jorge-Juan.Garcia-Garcia@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Tue Jun 18 12:56:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uota7-00010R-8N
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 12:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622Ab3FRK4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 06:56:06 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:43007 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab3FRK4F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 06:56:05 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so9649877ied.14
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 03:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VnnslRUwjkHHtQnNs7gh5Q4Ik0yffWOj36f4fEWYSE4=;
        b=yCWrxQyVWbeKWurb/tRaw7pgr2n/8VS0Bv3K0PX+MYVEpypq2KaoJGi2MUuIo3qPJ4
         +/XX6x2wEm8ak6eG2JZ91TQ4jUVvxiCr4Zp7rQ8acplfC6o/0P15Cb6LdXRCQrVJiCuY
         SSk2iWkdk8A9C4gO4r8k7NQwwX4gsp0h4Xm4/36FRG4XI0luaiWQRg4jasLG+xMune16
         K4XwBSfcqSsFjAdm0Da+nc9V6kACzEVzEISGANMNdWMYt+AcZ3s356zo7lLi5oBN5G/k
         gre4LUaw1FtxSD8KJoXmXWT5aTU+nZAd3pUSJVti9qleNu6j0DYuWZKTWO9K82DQih5d
         DCKw==
X-Received: by 10.50.79.231 with SMTP id m7mr7141537igx.40.1371552964142; Tue,
 18 Jun 2013 03:56:04 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 18 Jun 2013 03:55:23 -0700 (PDT)
In-Reply-To: <1371549079-19291-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228194>

Jorge-Juan.Garcia-Garcia@ensimag.imag.fr wrote:
> +sub split_email_list {
> +    my(@list) = @_;
> +    my @tmp;
> +    my @emails;
> +       for (my $i = 0; $i <= $#list; $i++) {
> +           if ($list[$i] =~ /,/) {
> +               @emails = split(/,/, $list[$i]);
> +           } else {
> +               @emails = $list[$i];
> +           }

Perhaps use map like in sanitize_address_list and
validate_address_list to prettify this?
