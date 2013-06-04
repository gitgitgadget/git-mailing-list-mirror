From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] t/README: test_must_fail is for testing Git
Date: Tue, 4 Jun 2013 21:16:38 +0100
Organization: OPDS
Message-ID: <AAD729AEE8D044B89388799A7CC7552A@PhilipOakley>
References: <CAGLuM14_MQffwQWrB2YCQXzhkGaxdaYBuY74y7=pfb-hB6LskA@mail.gmail.com><CACsJy8BqCUKhc8vhjhNz0OedBngk7zcSOk70ekRm3EiruHfNxA@mail.gmail.com><CACsJy8DD=LxAKh_fUELJ5Mj0xS_gZE88N_rJFkKGer=YAOqsMg@mail.gmail.com><51A62A96.6040009@gmail.com> <51A665E4.9080307@gmail.com><CACsJy8D4wmhGkEsn8r5OEQv_hX=OFD5W8abnBnYFcFCQZfLOoQ@mail.gmail.com><7vk3mcnwlj.fsf@alter.siamese.dyndns.org> <7vppw195x7.fsf_-_@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Karsten Blees" <karsten.blees@gmail.com>,
	"Duy Nguyen" <pclouds@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 04 22:16:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujxeu-0006l0-4O
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 22:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204Ab3FDUQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 16:16:41 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:24829 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751127Ab3FDUQj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jun 2013 16:16:39 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtYNAHpKrlFOl3th/2dsb2JhbABUBoMJiSu2JQQBAwF6F3SCHgUBAQUIAQEuHgEBIQsCAwUCAQMVAQslFAEEGgYHCQENBgESCAIBAgMBiAC9eY1+PGqDAWEDiGiGBZJthyWDEDs
X-IronPort-AV: E=Sophos;i="4.87,802,1363132800"; 
   d="scan'208";a="74324037"
Received: from host-78-151-123-97.as13285.net (HELO PhilipOakley) ([78.151.123.97])
  by out1.ip07ir2.opaltelecom.net with SMTP; 04 Jun 2013 21:16:37 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226398>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Tuesday, June 04, 2013 5:50 PM
> When a test wants to make sure there is no <string> in an output
> file, we should just say "! grep string output";

Small nit: It took me two readings of the commit message to correctly 
parse this break point. The flowing together of the two parts with the 
semicolon fooled me. Separate them?

>      "test_must_fail"
> is there only to test Git command and catch unusual deaths we know
> about (e.g. segv) as an error, not as an expected failure.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> t/README | 3 +++
> 1 file changed, 3 insertions(+)
>
> diff --git a/t/README b/t/README
> index e669bb3..35b3c5c 100644
> --- a/t/README
> +++ b/t/README
> @@ -324,6 +324,9 @@ Don't:
>    use 'test_must_fail git cmd'.  This will signal a failure if git
>    dies in an unexpected way (e.g. segfault).
>
> +   On the other hand, don't use test_must_fail for running regular
> +   platform commands; just use '! cmd'.
> +
>  - use perl without spelling it as "$PERL_PATH". This is to help our
>    friends on Windows where the platform Perl often adds CR before
>    the end of line, and they bundle Git with a version of Perl that
> --

Philip 
