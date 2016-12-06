Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 885DB1FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 19:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752594AbcLFTrd (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 14:47:33 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:36307 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbcLFTrb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 14:47:31 -0500
Received: by mail-io0-f195.google.com with SMTP id s82so8940080ioi.3
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 11:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c5jBYuIu2/eZvbSGD0mUx4xFsyaY7outUvlebBTr9Y8=;
        b=wbGZ01Kvw89+KDKJzkx0def0vf3js3cPAkF+gBtzhFstmEyMlctQEsijpMvvMa900O
         5RdNK3gyBsbl9KP+/3ct06ZFiT6wTmGg/+C/SXFV8sw7W9egK9ZpP1VYUiMUU9IpOu+6
         e7CQmnAnzKZq5VM7Yeq+zUfyTM0siuE7UxqW9YS3PZvXJRCxhPdXglMe/cZvt0BBkbXF
         q4oq8D/Lch7e9+QKof2pU/hn1kQ6YmyT8gWvi4yQezjdPIz1/hcomQC90DcZRL7atD/H
         kKIhLeN1NRqUbvO0ZNXzqenXsa3OMZqTapia7iT9rPfp2Kg4pOFOyo5B6BcDaagJ2jcs
         CH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c5jBYuIu2/eZvbSGD0mUx4xFsyaY7outUvlebBTr9Y8=;
        b=XcscJZsE2NKkeEsbZ5sRVHwEjdcGfb9kTOUrMaBDyl6miE5pdwgbYYSqH6d79LhfRi
         sGl3QnjDDBW9rArGA5j9mEbGM1QrxbtpoSEmGhYf9jQW7L8CWhXEAfrwrwZuwiDtC6Jc
         NceLPM2acQNEyH+s7R2HV20QV89Kp0afCcV/AWgW56RnlgMNTNuX4yFSdwv1nirzbv/9
         +NSx4XQyYfW2bRZHUBaHsoq7B6G2sTQoUeX9zdjOwIZ+hrQQHFkvFQ0Fur0wdBE5WFSi
         Le+kIgS8NeqMXsezPimhySx0a1nxlDupNJJjPXF5znhPywRiYy6Cz3jhGsELV6R2SsNo
         U7ng==
X-Gm-Message-State: AKaTC01AxPgmDW3DFkoRalV5YcYmYkmPqShYiSEuA6vzWxnLf7HITIv8+A2YholZgpYsPYa8EG3VHLz2UEQwuw==
X-Received: by 10.107.141.211 with SMTP id p202mr52638448iod.47.1481053650831;
 Tue, 06 Dec 2016 11:47:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.137 with HTTP; Tue, 6 Dec 2016 11:47:30 -0800 (PST)
In-Reply-To: <723476f6-2c8c-38df-1771-9a525196d9de@gmx.net>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1b1a-067117ef-cd0d-469b-ba80-ea1a1169f694-000000@eu-west-1.amazonses.com>
 <723476f6-2c8c-38df-1771-9a525196d9de@gmx.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Wed, 7 Dec 2016 01:17:30 +0530
Message-ID: <CAFZEwPPMb+1SzadRyhyjnz1U=wKN+2eaMr2xd3Aq6TU1wwicgQ@mail.gmail.com>
Subject: Re: [PATCH v15 18/27] bisect--helper: `bisect_autostart` shell
 function in C
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Stephan,

On Mon, Nov 21, 2016 at 1:45 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi,
>
> On 10/14/2016 04:14 PM, Pranit Bauva wrote:
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> index 502bf18..1767916 100644
>> --- a/builtin/bisect--helper.c
>> +++ b/builtin/bisect--helper.c
>> @@ -422,6 +425,7 @@ static int bisect_next(...)
>>  {
>>       int res, no_checkout;
>>
>> +     bisect_autostart(terms);
>
> You are not checking for return values here. (The shell code simply
> exited if there is no tty, but you don't.)

True. I didn't notice it carefully. Thanks for pointing it out.

>> @@ -754,6 +758,32 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
>>       return retval || bisect_auto_next(terms, NULL);
>>  }
>>
>> +static int bisect_autostart(struct bisect_terms *terms)
>> +{
>> +     if (is_empty_or_missing_file(git_path_bisect_start())) {
>> +             const char *yesno;
>> +             const char *argv[] = {NULL};
>> +             fprintf(stderr, _("You need to start by \"git bisect "
>> +                               "start\"\n"));
>> +
>> +             if (!isatty(0))
>
> isatty(STDIN_FILENO)?

Seems better.

>> +                     return 1;
>> +
>> +             /*
>> +              * TRANSLATORS: Make sure to include [Y] and [n] in your
>> +              * translation. THe program will only accept English input
>
> Typo "THe"

Sure.

>> +              * at this point.
>> +              */
>
> Taking "at this point" into consideration, I think the Y and n can be
> easily translated now that it is in C. I guess, by using...
>
>> +             yesno = git_prompt(_("Do you want me to do it for you "
>> +                                  "[Y/n]? "), PROMPT_ECHO);
>> +             if (starts_with(yesno, "n") || starts_with(yesno, "N"))
>
> ... starts_with(yesno, _("n")) || starts_with(yesno, _("N"))
> here (but not sure). However, this would be an extra patch on top of
> this series.

Can add it as an extra patch. Thanks for informing.

>> +                     exit(0);
>
> Shouldn't this also be "return 1;"? Saying "no" is the same outcome as
> not having a tty to ask for yes or no.

Yes.

>>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>  {
>>       enum {
>> @@ -790,6 +821,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>                        N_("find the next bisection commit"), BISECT_NEXT),
>>               OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
>>                        N_("verify the next bisection state then find the next bisection state"), BISECT_AUTO_NEXT),
>> +             OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
>> +                      N_("start the bisection if BISECT_START empty or missing"), BISECT_AUTOSTART),
>
> The word "is" is missing.

Sure. Thanks for going through these patches very carefully.

Regards,
Pranit Bauva
