From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 6/8] receive-pack.c: add a receive.preferatomicpush
 configuration variable
Date: Thu, 30 Oct 2014 15:26:47 -0700
Message-ID: <CAL=YDWms5geok1j8tQUjHaOVTSG-_zbTob_AVX0GS8cA0rwaSQ@mail.gmail.com>
References: <1413924400-15418-1-git-send-email-sahlberg@google.com>
	<1413924400-15418-7-git-send-email-sahlberg@google.com>
	<xmqq7fzhuxlh.fsf@gitster.dls.corp.google.com>
	<CAL=YDWmNXpe=0UxbHD-5pwNW-hdp=Ja1Xy8gXAKcbSkoJhpgRw@mail.gmail.com>
	<xmqqy4rxtdu5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 23:26:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjyBA-0007Zu-VQ
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 23:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161211AbaJ3W0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 18:26:49 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:61925 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161019AbaJ3W0s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 18:26:48 -0400
Received: by mail-qg0-f46.google.com with SMTP id i50so3781753qgf.19
        for <git@vger.kernel.org>; Thu, 30 Oct 2014 15:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ND1Pbayt+k3Q/niudV2QdSUEK4q75E81JzYuzBcRil8=;
        b=f3z0miqeaJOv/Q+CYlWp59KLiHhyb0Bsbjx1iR628Mrgs4SMRYamyhiCXp0muoGvIf
         6DlNV47X5zhDslHpC3NrRY2e4A2Pc+pkni9uiX0vIx88osQUhiVYwWsygYKNfwJ5psqa
         +utkmU6lr18QLGyTnIFUGModKfH9I66inkImLfuSHNy3tvzsLtsI81qXCqc8NLDJw/hv
         ZaprIjJG8M6BM+qcAzKk8TNFDLlmL7+5mqK4wW53xAexGQItsiI1sbV/wAzGTXnBUKAF
         S/t+DmW1yxltJmPB8m0s5uGCs90SkUPsVPDnyO+wQPdYcJvBcE/Cp3eKK2X8pAx/YpGH
         52hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ND1Pbayt+k3Q/niudV2QdSUEK4q75E81JzYuzBcRil8=;
        b=E8KQy1mOAqt5ewJeCysJv1riUC5NO2SjV9iZ6h0mGsX2GXifwH/IiXMZ30Gn45slC4
         2ML6+LhyAkg12uw1b1T8gmJyoX0bbdyX+7LASeydKgBFeEtYAEpjQMbDKCztQuRVRoIQ
         OGQeIn/z3fBAdiig6PYCiJsSU80lga1i/b/NusKymte2EmtkItrxOP7qGPT69s5gOZqD
         HjyuXpW2lpVZUI4JFIfqM/sXS+hAXPrYXjvGBLFXx3lUDA0S6iYCEc4wAkdLAX9zQjsa
         y9KTno+i493YdJmxbH1OnGwX/9gJtAizEryW3NtBbmV/N7YjnyPGN+MyhxWPsfm5ikhu
         b7cQ==
X-Gm-Message-State: ALoCoQknub8vfnNss/zRPNeK5hvEH+cvvgV7S5i+LQFiDZDur1sh3kU+G3gGRNjKsT8PqGJRFd7a
X-Received: by 10.140.109.244 with SMTP id l107mr28669262qgf.80.1414708007440;
 Thu, 30 Oct 2014 15:26:47 -0700 (PDT)
Received: by 10.229.225.202 with HTTP; Thu, 30 Oct 2014 15:26:47 -0700 (PDT)
In-Reply-To: <xmqqy4rxtdu5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 30, 2014 at 3:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> At some stage it may becomes too many preferences and over-engineered.
>> Maybe I should drop this patch and then just require the plain "if you
>> want a push to be atomic, then use --atomic-push. end." and we have
>> simple and easy to understand semantics.
>
> As I still do not quite understand why you find that this could be a
> "convenience preference" on the server operator's end, that would be
> my preference, at least until I am convinced why this could be a
> good idea.
>
> Thanks.
>

Ok,  I dropped this patch.

Thanks
Ronnie Sahlberg
