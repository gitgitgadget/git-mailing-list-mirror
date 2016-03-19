From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: parse-options does not recognize "unspecified" behavior
Date: Sat, 19 Mar 2016 22:25:35 +0530
Message-ID: <CAFZEwPNK+XTjXzjn-Pv3iP4XiajXrdhUHWLz-8c0Ssy_Edkd7A@mail.gmail.com>
References: <20160317014310.GA12830@sigill.intra.peff.net>
	<1458386735-8038-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Mar 19 17:55:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahKA9-0005G9-MZ
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 17:55:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891AbcCSQzi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2016 12:55:38 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:36802 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625AbcCSQzg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2016 12:55:36 -0400
Received: by mail-yw0-f176.google.com with SMTP id g3so173603205ywa.3
        for <git@vger.kernel.org>; Sat, 19 Mar 2016 09:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=MS4Ws2ZLbtqgO0siMeOdxE6BpbU5j6ELZPTPPUrhPQA=;
        b=uxH/Xg9NWnMOrfqg7RZUY02sih2R3d6WLT3E06XisHDBN20jOiDteqqmaiASAhPBf2
         I9YEPo3foF5ED8tZ2GwLILaW0J10Diclo3FY7PGAO1UY5Z9fcxQM4LMzgCCJ9a8zghA+
         OM2vHVso/iuB+vF+MFfIOgGPNRpN67p3NwWB1pK5RLkCKt4GRUiXRbs9Rr44kY5wUd+e
         g+Io/no86SDH7Vyak5cT4PP0acezsX9OcmVzD8q0uFETpegpTz5cW/wf4Ngpjg+g10xA
         0ameVXIdlP1gEaJrcgUMJoFnIYb3PNNmS/DdZtBOPzu1ri5bs+ieWQ+1VxtHo0WcHhPw
         EMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=MS4Ws2ZLbtqgO0siMeOdxE6BpbU5j6ELZPTPPUrhPQA=;
        b=XmLpZeHOnOgdmUVlx6M11AX08N+/UvgUXwidAP4l3Ip+qAPLVDTTcNJc5YwRx4NhUB
         Vi4YbAB+WTbAV9w5lMzGZMoF0+RFbAJ+cgGTjoaIUesRm7A2MDU4BJW9dhowoj75Tf8G
         HDST+aT4j4ZYFqkY9BEvQ9/v0M6U4cERfkVMChvivmJ1asy7Bp45zYMEy9Ug+hnIU1nk
         vFuUfvMtEjW+2a7yeEeT2pZQtnLcIOukF4pb5z5UAJQuuRU5qX2+P9lN3cc1Yp696tuZ
         jKNBccPBR3ul6RM75GaX7/nwKEuskACvDIKDKzxN6FieaECOeRPpTGSfLFsfK0XZjLPQ
         ikeQ==
X-Gm-Message-State: AD7BkJLEDUU+dxx/3QJ1WUU5i0duOQSNGHITe1FrxTtCGb07HgZ2foXJG/dXBF+FK1+g9k+cDY8Pw1JmSXVQPQ==
X-Received: by 10.129.45.194 with SMTP id t185mr9450767ywt.243.1458406536037;
 Sat, 19 Mar 2016 09:55:36 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Sat, 19 Mar 2016 09:55:35 -0700 (PDT)
In-Reply-To: <1458386735-8038-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289314>

On Sat, Mar 19, 2016 at 4:55 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
>> Yes, I think in general, "-v" and "-q" should work as opposites. But
>> that is not the case with commit, where "-v" and "-q" operate on tot=
ally
>> separate messages. I think that is a UX mistake, and we would not do
>> it that way if designing from scratch. But we're stuck with it for
>> historical reasons (I'd probably name "--verbose" as "--show-diff" o=
r
>> something if writing it today).
>
> Yeah, as a long-time 'git commit -v' user I never really thought abou=
t
> the name of the option, but when I pointed out the multiple verbose
> levels it struck me as a rather unfortunate name for this feature,
> too.  Oh, well, we are stuck with it indeed.
>
> However, that doesn't mean that we have to spread this badly chosen
> name from options to config variables, does it?  I think that if we
> are going to define a new config variable today, then it should be
> named properly, and it's better not to call it 'commit.verbose', but
> 'commit.showDiff' or something.  Perhaps we could even define two new
> config variables: 'commit.showDiff' for the diff of the changes to be
> committed (=3D '-v'), and 'commit.showUnstagedDiff' for the - wait fo=
r
> it! - unstaged changes (=3D '-v -v').  Not sure about the variable
> names, though, because "plain" 'git diff' shows unstaged changes,
> while 'git diff --cached' shows staged changes.

This seems a better way to go about.

>
> Furthermore, it doesn't mean that we can't add properly named command
> line option(s) and state that '-v|--verbose' is a synonym to
> '--show-diff' (maybe even deprecate '--verbose'), but I don't want to
> squeeze even more into a GSOC micro project.

Its perfectly fine. It hardly a half an hour job. Though I like the
idea that we should use both "-v|--verbose" and "--show-diff" instead
of deprecating it. Plus, this edit would not be required. What are
your suggestions?

Regards,
Pranit Bauva
