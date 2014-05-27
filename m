From: Brian Gesiak <modocache@gmail.com>
Subject: Re: [PATCH 01/15] builtin/add.c: rearrange xcalloc arguments
Date: Tue, 27 May 2014 20:32:54 +0900
Message-ID: <CAN7MxmXVDTiQv5J9cU2E8iS=BNROw3q9NVaBuG7aQP-7=Qo_ZQ@mail.gmail.com>
References: <1401118436-66090-1-git-send-email-modocache@gmail.com>
	<1401118436-66090-2-git-send-email-modocache@gmail.com>
	<CAPig+cRE0LUaNLTJARBCmoDn7cR1bbgi8At0ChgSDWBjDPaNjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 27 13:33:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpFcp-0003JT-Gf
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 13:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbaE0Lc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 07:32:56 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57671 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbaE0Lcz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 07:32:55 -0400
Received: by mail-ie0-f174.google.com with SMTP id lx4so8370341iec.5
        for <git@vger.kernel.org>; Tue, 27 May 2014 04:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UEcMJW62WiQVJIkdWpxzWtFegfpCT+Yc8e9GhLa24Yw=;
        b=sscGLRJTNWBbx/dP94pRnZYIw1dQjdj8YkIDVMxUMaN1kkR2K4jBvuD0KtmcOaXW6M
         lH41vFr+AP/sGaKvk9bpHeO4dktkTqeCjUt2snJwBMmO33s6Wsl2YzSSMD+Zimh/qk9h
         QPi3IhsAamRmRsUk41L2NPi8nCqc8aG11+M8jOrsJU1lsZhLZYx4yF/zx6ojjZntZuJR
         5YTt5atkDFaAmGweTYSUamGqU4N6lR223iWOvskvF61T1odksniYkmFjU4KjoANyerQ0
         9sDokWhWT+ALcvL9K62ln8mTnQz4S3xTkGXZ5/eOrLTLA0KDyn9EU3WWo7tFBxaTnOJy
         sJUg==
X-Received: by 10.42.233.12 with SMTP id jw12mr3323838icb.12.1401190374774;
 Tue, 27 May 2014 04:32:54 -0700 (PDT)
Received: by 10.64.55.165 with HTTP; Tue, 27 May 2014 04:32:54 -0700 (PDT)
In-Reply-To: <CAPig+cRE0LUaNLTJARBCmoDn7cR1bbgi8At0ChgSDWBjDPaNjg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250161>

Oomph, how embarrassing. Thanks for pointing that out!

Would it be better if I rerolled the patches?

- Brian Gesiak

On Tue, May 27, 2014 at 12:25 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, May 26, 2014 at 11:33 AM, Brian Gesiak <modocache@gmail.com> wrote:
>> xcalloc takes two arguments: the number of elements and their size.
>> run_add_interactive passes the arguments in reverse order, passing the
>> size of a char*, followed by the number of char* to be allocated.
>> Rearrgange them so they are in the correct order.
>
> s/Rearrgange/Rearrange/
>
> Same misspelling afflicts the entire patch series.
>
>> Signed-off-by: Brian Gesiak <modocache@gmail.com>
>> ---
>>  builtin/add.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/add.c b/builtin/add.c
>> index 672adc0..488acf4 100644
>> --- a/builtin/add.c
>> +++ b/builtin/add.c
>> @@ -248,7 +248,7 @@ int run_add_interactive(const char *revision, const char *patch_mode,
>>         int status, ac, i;
>>         const char **args;
>>
>> -       args = xcalloc(sizeof(const char *), (pathspec->nr + 6));
>> +       args = xcalloc((pathspec->nr + 6), sizeof(const char *));
>>         ac = 0;
>>         args[ac++] = "add--interactive";
>>         if (patch_mode)
>> --
>> 2.0.0.rc1.543.gc8042da
