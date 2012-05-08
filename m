From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] checkout: do not corrupt HEAD on empty repo
Date: Tue, 8 May 2012 18:35:10 +0200
Message-ID: <CABPQNSb-YPAa6qPtxeo1k-p-0REnk3soOTuPgABj9+s61o80VA@mail.gmail.com>
References: <1336493114-4984-1-git-send-email-kusmabite@gmail.com> <7v4nrqy6ur.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, j.sixt@viscovery.net, schwab@linux-m68k.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 08 18:36:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRnOG-0006EI-Mf
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 18:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756530Ab2EHQfw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 12:35:52 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38166 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755957Ab2EHQfv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2012 12:35:51 -0400
Received: by pbbrp8 with SMTP id rp8so8241151pbb.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 09:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=vC0WX+WKrsdH+CuwIu6W3CJ4PqZIy+aDqqz+RUTo1NU=;
        b=K94OQEWcPTlZR+oVY2FkrhfobcDCy33PRpnnUadgfIG8sXpmI4SgsCovos9Eh66ACU
         DbALizhEoRtioIX4CjTCtdNfxk8+eQYfzXtJt4EKvTsra0Y5GybNTpyG/YH5L/dCr4Yk
         pXCkBH8TPceNqr45fCJ9Jg6sMtW5IAIbUKNiFUy+TrLxDEL+oJU57Aftv2vEHOW+7DDp
         /ap1zK+bGjiI/MYRNFdhf453+GRHi9TuHF1pN5xzceXBm1NpBdzSKtAWug3cWcO9Qp07
         KF/2Qx1V4MbpRXyZBsTqk1o0hvlFpheuRLy+dIscWdiIJRjug55nQ4LcSWH9r14COaAk
         vKUQ==
Received: by 10.68.132.41 with SMTP id or9mr11486145pbb.30.1336494951141; Tue,
 08 May 2012 09:35:51 -0700 (PDT)
Received: by 10.68.73.65 with HTTP; Tue, 8 May 2012 09:35:10 -0700 (PDT)
In-Reply-To: <7v4nrqy6ur.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197387>

On Tue, May 8, 2012 at 6:29 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> In abe1998 ("git checkout -b: allow switching out of an unborn
>> branch"), a code-path overly-optimisticly assumed that a
>> branch-name was specified. This is not always the case, and as
>> a result a NULL-pointer was attempted printed to .git/HEAD.
>>
>> This could lead to at least two different failure modes:
>> =A01) The CRT formated the NULL-string as something useful (e.g
>> =A0 =A0 "(null)")
>> =A02) The CRT crasheed.
>
> Just a quick question. =A0What does a cathode ray tube have to do wit=
h this
> (or "are people expected to know what CRT you are talking about?")?
>

=46eel free to change it to "the C runtime", or even "the vsnprintf
implementation" if you feel like it :)
