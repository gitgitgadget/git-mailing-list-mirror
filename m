From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v12 4/5] t7507-commit-verbose: improve test coverage by
 testing number of diffs
Date: Sun, 3 Apr 2016 21:05:09 -0400
Message-ID: <CAPig+cQGeqvmTz1SdpJG137PgR=bC0d_Nu_q_ofhZM1BCYoxjQ@mail.gmail.com>
References: <01020153d952bd99-d3812bd6-d189-4780-ab48-f015696e9cf0-000000@eu-west-1.amazonses.com>
	<01020153d952be6c-04f90bd2-291e-4eca-99fd-e897d8601132-000000@eu-west-1.amazonses.com>
	<CAPig+cRBwOjxA2cB=ZR__o7LsHxk9Rbzfv7ngRxv8h6=koQSRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 03:05:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amsxC-0006V8-7G
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 03:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbcDDBFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 21:05:11 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:34538 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779AbcDDBFK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 21:05:10 -0400
Received: by mail-ig0-f193.google.com with SMTP id qu10so3942187igc.1
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 18:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=CBVHlMrsiyIHafeaHTVGhaUy4kZBlxhITLqrbH6YXa0=;
        b=maeaAm3cYtTVht1nc5XeZMFXxVBnesYjoqmnuqzbsE4jDcJoHVzsnEnaoMO3H+eEOW
         2Gu34aCNYM2QX9tCWQEHcvL0iPOQ3eatHCVvvRlabjFlyc9R6JIIt/aY+c3L6btOc/mP
         dNCi7FGXeN08ZHVZWxtHH8DLdVF+yAtYHkLT0+3/Ogr+A9nvowJONMUitFF1OCpe9u9R
         r2VypxhpLZRDwAUlIkax5/YS1pJVlLU6gVLJpfo3dQPYaX2XTEnhm+ZC0PjFJ7zAI6dN
         isLL5u9p3GzzF0GR0fNWNLRX+saE/2hJqROagbjhJSfc4IFdApSqjM6DKqguH9t+mFD4
         zymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=CBVHlMrsiyIHafeaHTVGhaUy4kZBlxhITLqrbH6YXa0=;
        b=BDDXFKK0pvZ5AFlJeeFUxwkEOFMQ7oqB7J1EddIoeUll616RwQvSZRcjQKFik68W9r
         f0T4X2LzdKiNGnDYdFHQz10iBgiSMVheQGeer2fkQSwAx8OuWcHfBDc1gXqqpB4V9srI
         5K8coL5tU+sVFzpE8W75MhrmzRXUSOjj3KokGx7SgMfVp7M5B4/Q8XVl6yCYl+vtKMGW
         aEtjOez3mVj6AFEXz/7yja0EOdyIHlz+nMg0+aVDWF6+sIBgsv/lvRTlc2O9ooGoPQ2k
         ALJPzyCn9Cg33rg5rNEnL0Ll68kJYTXik5QpYUPxw90fOoIz9vjh5zDzsGmoq7y1RDC5
         LP6A==
X-Gm-Message-State: AD7BkJKr2eqSdeqhvqlCogrhL0MxE9UmLDUT4Nv0btH2g1str9/2eCeBgP6004dHP/QTIHZ9hF/f5HwQJ+TmNg==
X-Received: by 10.107.47.41 with SMTP id j41mr13478818ioo.168.1459731909263;
 Sun, 03 Apr 2016 18:05:09 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Sun, 3 Apr 2016 18:05:09 -0700 (PDT)
In-Reply-To: <CAPig+cRBwOjxA2cB=ZR__o7LsHxk9Rbzfv7ngRxv8h6=koQSRw@mail.gmail.com>
X-Google-Sender-Auth: hZj_l5EvsdHDlcj6-iM1PsVeW6Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290665>

On Sun, Apr 3, 2016 at 8:02 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Apr 2, 2016 at 7:33 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Make the fake "editor" store output of grep in a file so that we can
>> see how many diffs were contained in the message and use them in
>> individual tests where ever it is required. Also use write_script()
>> to create the fake "editor".
>>
>> A subsequent commit will introduce scenarios where it is important to be
>> able to exactly determine how many diffs were present.
>
> These two sentences are backward. The "subsequent commit" bit is
> justification for why you are making the "editor" store the output,
> thus it belongs with the first paragraph. The bit about write_script()
> is just a minor aside which can go in its own paragraph.
>
> I think it's also important to explain that you're changing the
> behavior of write_script() so that it always succeeds, regardless of

s/write_script()/the fake "editor"/

> whether grep found diff headers or not, and to give the reason for
> making this change ("so that you don't have to use 'test_must_fail'
> for cases when no diff headers are expected and can instead easily use
> 'test_line_count = 0'").
