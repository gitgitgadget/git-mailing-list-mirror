From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 1/5] command-list.txt: prepare with [commands] header
Date: Fri, 15 May 2015 16:52:19 -0400
Message-ID: <CAPig+cSjHyh5eO6KWYMo_OxUmDQWP9TnnuaBvnBGWVDh7pesOQ@mail.gmail.com>
References: <1431714904-16599-1-git-send-email-sebastien.guimmara@gmail.com>
	<1431714904-16599-2-git-send-email-sebastien.guimmara@gmail.com>
	<xmqqr3qhfuz3.fsf@gitster.dls.corp.google.com>
	<5556582C.3010409@gmail.com>
	<xmqqmw15fu5m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 15 22:52:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtMao-0005cX-Mq
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 22:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423104AbbEOUwW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2015 16:52:22 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36572 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422676AbbEOUwU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 May 2015 16:52:20 -0400
Received: by iepk2 with SMTP id k2so130146032iep.3
        for <git@vger.kernel.org>; Fri, 15 May 2015 13:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=1zmCaPy5CYoJ2tB2Af88x7C1qwZXow/gsiZossZmVZ0=;
        b=dlH0oeInKVTkO7IaM8udHHvhi5XLp3auAA4Uvj9qutZ0IbUWtSxtCeV51SA/yoFru8
         vC9+pMq1CJu/xTPveJCqVKtoOXIADfK0QaXGAa2lG6yWKslPR2POAonW0vaTV3GaoBN9
         TlPbSbsoINvz+3g9A61zxk6p4fOcJdR0GgSq3e7jVTl1XJNuNAYs+Si49NbrU2W9WLGo
         Hd9NY09Yk06oECrC+uZxCZoVTG5iyD85dbFOABaYIT0KeB0GNCrFOFfnnsE2zGXS7xy/
         LFOU6h9zkLoO1zNtFP3pEbAVq0sTj7iGQtgwRBwCjAkoqujlyCl1WXi/il2mYETNn/TY
         4ipA==
X-Received: by 10.50.43.227 with SMTP id z3mr698163igl.22.1431723139623; Fri,
 15 May 2015 13:52:19 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 15 May 2015 13:52:19 -0700 (PDT)
In-Reply-To: <xmqqmw15fu5m.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: dYP_T4olfrne7YYY2NvOTJJbcMI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269184>

On Fri, May 15, 2015 at 4:44 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> S=C3=A9bastien Guimmara  <sebastien.guimmara@gmail.com> writes:
>>> You could for example have used the existing "# List of known git
>>> commands" as such a signal to tell that all the no comment lines
>>> below are commands.
>>
>> I tend to think that relying on comments as marks for parsers is bri=
ttle,
>> but indeed square brackets get in the way of sed regexes. I'll think=
 of
>> something better. Thanks.
>
> Heh, we, and more importantly our users, already rely on a marker in
> comments when writing their commit log messages ;-)
>
> I would not be opposed to a new header that is outside comment, but
> I do not think the marker line that is also a comment is "brittle"
> and would not be opposed to that, either.
>
>     # do not molest the next line
>     ### command list
>     # name category
>     git-add mainporcelain
>     ...
>
> would be perfectly acceptable.
>
> I was just pointing out that you did not even have to have patch
> 1/5.

Is that entirely accurate? The machinery (Makefiles, cmd-list.perl)
does have to be updated at some point to skip the "common" block which
get added in patch 2/5. That work could be done as part of patch 2/5,
though it seemed cleaner to me to make it separate (though I don't
care too strongly).
