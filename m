From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] test: improve rebase -q test
Date: Sun, 9 Jun 2013 13:35:21 -0500
Message-ID: <CAMP44s3Pny7JkyHbLZ3kUemNK70JhdYWdpELTjNLz0y3Z2V3+A@mail.gmail.com>
References: <1370637143-21336-1-git-send-email-felipe.contreras@gmail.com>
	<1370637143-21336-3-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8DHeqOz=WbxurCvPiDq73k4eftwrEEZzWBbifS51PDbLQ@mail.gmail.com>
	<7vd2rvqgra.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 20:35:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlkSd-0008Rw-PS
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 20:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994Ab3FISfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 14:35:23 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:53124 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab3FISfX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 14:35:23 -0400
Received: by mail-lb0-f172.google.com with SMTP id v20so1187785lbc.31
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 11:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KZnSpNxcmut9lUtp1SnMUOEoSl6Q7ej+Xe/Kqo7vtfk=;
        b=I6s4BIMe/IGJ1luedWQOk2v30yqDW6Vzw1RtlSnnz/ifBqKyxh12OxC3BX4btUG0yL
         FJcwrzxklMW4ZJay9kW44MXHhhr9Vla8TxY2OLLZ2NorxVhGFHS+TY9xa0NBAzRH6p3+
         mgMTY5fIBiTxS7cvX9/kcLKwYS15vVE6e7MGMBSJDRa/3mYrP7PBhv8uSGBTVZYL22/h
         o0AlOiInhnzj7Ipq6yD10VahAN5vhOnfZmYMQMl1KePvqYQPNHH40bWnrY3kAjIm1Ozy
         soS+hOpTShd//zKapwwnF19Jk4vhlV5GlmfV2A11AfjbfscxT/mIuVLiVnvhZazMGUbo
         fSqg==
X-Received: by 10.152.43.136 with SMTP id w8mr3364391lal.63.1370802921540;
 Sun, 09 Jun 2013 11:35:21 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 11:35:21 -0700 (PDT)
In-Reply-To: <7vd2rvqgra.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227091>

On Sun, Jun 9, 2013 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrote:

> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -606,6 +606,18 @@ test_cmp() {
>         $GIT_TEST_CMP "$@"
>  }
>
> +# Check if the file expected to be empty is indeed empty, and barfs
> +# otherwise.
> +
> +test_output_must_be_empty () {

Why such a big name? test_empty() does the trick.

> +       if test -s "$1"
> +       then
> +               echo "Bad: test_output_must_be_empty '$1', but has the following."

echo "'$1' is not empty, it contains:"

Cheers.

-- 
Felipe Contreras
