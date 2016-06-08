From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 63/94] builtin/apply: make apply_all_patches() return
 -1 on error
Date: Wed, 8 Jun 2016 13:44:22 -0400
Message-ID: <CAPig+cQpk4Kknbudu1Ki3T9=rsO9+q4BCR6C2-1xjgUE0HSJYg@mail.gmail.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
 <20160511131745.2914-64-chriscool@tuxfamily.org> <CAPig+cQAM8i2sFY9UUYfN23PRGgFacG7KiTD6mZwnm=PgKBL7A@mail.gmail.com>
 <CAP8UFD2jA7ydsYTkQLbQJTW7NFRpkmJwgJQp=UZ0-8-7njSawA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 19:49:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAhWm-0001bw-Rm
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 19:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430AbcFHRoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 13:44:25 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33424 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378AbcFHRoX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 13:44:23 -0400
Received: by mail-it0-f67.google.com with SMTP id u203so2204646itc.0
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 10:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jD2cNutu8ci0ZviskIZSV2oBqOuslinmmR/3o+mi460=;
        b=bjISThnarWwTcRGpmvzNcPTXshxeVDMJPCPM62tfM8n8dgoZi8qjZXHIQ6tfrHIJYp
         Wq7jx46kEdAPPDTmEVpHdSY07wIYpAuOVAHoDxvHV5Y57crsFYVDhnZHDp0Da14RKH6G
         +p7lzlGZ99V0kyfuE0xNQTnNmSW1eM+6jjietiAL3O03JZ+u5WoSJdzAMJFIYGB2cG4j
         4FY7Y0Hyd1v+19qUkH08jhjOPwDT/pBBBcL1KgdCA+ZA/B3XzLzWSo6Xt73XIWlzOlYB
         U1gVBO31oBcrutguMC7bXfq7jg/CN2kwUmm22hzN4473EDihCAchaxlHNGr74QxtfjvI
         Ncxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=jD2cNutu8ci0ZviskIZSV2oBqOuslinmmR/3o+mi460=;
        b=HMw9vsPE9xcSEWA49gjdnLhKD5ekqLe0zFh9iKuovXF9TP6pQYVuII1xjzg9rVyh8l
         UrCaoThoC9Lux60Jm8DblLKhQJmzQsb8i418okqCr7J8mZlmYcNFvOEdPN+vuD2EwBY3
         UNRHZ4h/uqptHxO3ibwzj2NNpQ+9T/Pk0HHwaNENOmVTxtkmbbxohwF1VsiN7CYO/gZV
         PecQNorvo1CTxDUrUPozEdIxn1y/U+Mpv8s6MGivdcv4xWN4JjkXoMrjca0qZeuTfOiV
         NwkTYSjw0SCCyTZPnK1iDY0k8PaTFJUEXnjJvzwb4FiMhRzCXydPCWNaJApiAzzCd1Z9
         3Q0A==
X-Gm-Message-State: ALyK8tJ3Qo2kXaDeWRDykauwk4sMhrSoCefd433ec7UStMzaqwnTmIjxmogzK5H30/sYDVSC1Wv/jIMedSkhww==
X-Received: by 10.36.98.136 with SMTP id d130mr14674743itc.84.1465407862812;
 Wed, 08 Jun 2016 10:44:22 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Wed, 8 Jun 2016 10:44:22 -0700 (PDT)
In-Reply-To: <CAP8UFD2jA7ydsYTkQLbQJTW7NFRpkmJwgJQp=UZ0-8-7njSawA@mail.gmail.com>
X-Google-Sender-Auth: DvZ435miCTs7AVhcy2wSZ8Z4_LI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296818>

On Wed, Jun 8, 2016 at 12:37 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Mon, May 16, 2016 at 5:44 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Wed, May 11, 2016 at 9:17 AM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>>>         if (state->update_index) {
>>> -               if (write_locked_index(&the_index, state->lock_file, COMMIT_LOCK))
>>> -                       die(_("Unable to write new index file"));
>>> +               res = write_locked_index(&the_index, state->lock_file, COMMIT_LOCK);
>>>                 state->newfd = -1;
>>
>> Does write_locked_index() unconditionally close the file descriptor
>> even when an error occurs? If not, then isn't this potentially leaking
>> 'newfd'?
>>
>> (My very cursory read of write_locked_index() seems to reveal that the
>> file descriptor may indeed remain open upon index write failure.)
>
> You are right, it is leaking newfd if write_locked_index() fails.
> The solution to that is to call `rollback_lock_file(state->lock_file)`
> and the following patch was supposed to do that:
>
> [PATCH v2 82/94] apply: roll back index lock file in case of error
>
> but it would do that only if `state->newfd >= 0` so we should set
> state->newfd to -1 only if write_locked_index() succeeds.
>
> I will fix this.
>
> I am also going to add a comment to this patch saying that this patch
> needs a following patch to call rollback_lock_file(state->lock_file)
> in case of errors.
>
> Or if you prefer, I can squash the patch that call
> rollback_lock_file(state->lock_file) in case of errors into this
> patch.

Squashing may indeed be preferable over leaving it in a "broken" state
until the next patch, though I haven't thought too hard about it.
Alternately, can the two patches somehow be swapped?
