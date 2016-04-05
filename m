From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 4/4] pretty: test --expand-tabs
Date: Mon, 4 Apr 2016 21:10:46 -0400
Message-ID: <CAPig+cSTp6R0XNwNAU=QhKOTqB4=uSuPd_mnwfvy6wHs8X7FRg@mail.gmail.com>
References: <1459293309-25195-1-git-send-email-gitster@pobox.com>
	<1459817917-32078-1-git-send-email-gitster@pobox.com>
	<1459817917-32078-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 03:11:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anFWh-00074Y-Ml
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 03:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbcDEBKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 21:10:47 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:34595 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbcDEBKr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 21:10:47 -0400
Received: by mail-ig0-f193.google.com with SMTP id qu10so185831igc.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 18:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=bmbNkD7hIqg2YnySXVDycFHKELXiSIeUC2TCfVJqPX8=;
        b=wwuuRAUpcczAx151Bsg2xxXo3ekpe6oqvVQxI9mLPyiVLUN3LUSOnEPqch5sDkqT7Z
         vzwSF3orozV15DCTJWa2WlclYu39ixYKnwMB8uZ+tCQHKKLkBRKSRwyqSkXA9ruHZEy/
         PBDart14ovjQ9+PCSQvrA2uJyOjZw/QuPSSv+eSgjvTqmzqt6dGz14CVmCAlm72QQ/wp
         EXkTlK9N9XZRAq1Hf/Lgc1u52Ythc1DFi7B+DaKzjR+nMC/+LU/ZLAAbJu/TI/9zlrGK
         enHHeLA/pFwNpuJuIv7Y+jwMEyzI1sTtfMtGWDoq/MXL1lqEOlIQ1Xye47edmYUoX/+w
         kuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=bmbNkD7hIqg2YnySXVDycFHKELXiSIeUC2TCfVJqPX8=;
        b=epEccdNGl8ray5X/U4RAfgHxitZh3b8mrPCHoUm39PtELfPweTlN9bLjXYvY8/Im6u
         +0qOEoQlwozlveGAVP26Hyq/7qXjKOa1utgk93uf8TJnikzRL2h5o4jdzoMuNROZicAQ
         2F+CRM1lc2FX7wzbSezFPukWjbgbxTQLhmjlwvIlZyFC9XknBKZTge7hQMsoCqB1BZWP
         aGoYGEU2daTua/0fk4s0fDI30+D/5Qh9luI5/7Fqdzcx2yWedKQgdyMxfqlKOChM27Lf
         JEnkyU29w5bBUFyBa1zdXuQyaGN8ZZNAdSE+optYaKhowqZKV30dNEeSN5SL7IyVwfQ9
         LJTw==
X-Gm-Message-State: AD7BkJKKMsQN4bocvkvAf2jX1/JXU1IkI1VECRbIn+uXnae9r2krGCTMAaj7XMe1CW9apb6hFzP0cvHLNAxKlw==
X-Received: by 10.50.143.102 with SMTP id sd6mr8545589igb.73.1459818646125;
 Mon, 04 Apr 2016 18:10:46 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Mon, 4 Apr 2016 18:10:46 -0700 (PDT)
In-Reply-To: <1459817917-32078-5-git-send-email-gitster@pobox.com>
X-Google-Sender-Auth: pIaReeS-Ius6LwhjbLgp8LwfZ0w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290745>

On Mon, Apr 4, 2016 at 8:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The test prepares a simple commit with HT on its log message lines,
> and makes sure that
>
>  - formats that should or should not expand tabs by default do or do
>    not expand tabs respectively,
>
>  - with explicit --expand-tabs=<N> and short-hands --expand-tabs
>    (equivalent to --expand-tabs=8) and --no-expand-tabs (equivalent
>    to --expand-tabs=0) before or after the explicit --pretty=$fmt,
>    the tabs are expanded (or not expanded) accordingly.
>
> The tests use the second line of the log message for formats other
> than --pretty=short, primarily because the first line of the email
> format is handled specially to add the [PATCH] prefix, etc. in a
> separate codepath (--pretty=short uses the first line because there
> is no other line to test).
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/t/t4213-log-tabexpand.sh b/t/t4213-log-tabexpand.sh
> @@ -0,0 +1,98 @@
> +count_expand ()
> +{
> +       case " $* " in
> +       *' --pretty=short '*)
> +               line=$title ;;
> +       *)
> +               line=$body ;;
> +       esac
> +       expect=
> +       count=$(( $1 + $2 )) ;# expected spaces
> +       while test $count -gt 0
> +       do
> +               expect="$expect "
> +               count=$(( $count - 1 ))
> +       done
> +       shift 2
> +       count=$1 ;# expected tabs

Why semicolon before the hash here and above?
