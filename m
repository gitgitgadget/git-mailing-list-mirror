From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 23/24] introduce GIT_INDEX_VERSION environment variable
Date: Wed, 21 Aug 2013 06:01:27 +0200
Message-ID: <87li3v4rqg.fsf@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com> <1376854933-31241-24-git-send-email-t.gummerer@gmail.com> <CACsJy8A_gJXUm2WVPCXDZbWFCusvyoEUJaGJT_ROC9uzxc_A6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 06:01:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBzc8-0005mp-MA
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 06:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073Ab3HUEBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 00:01:34 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:38975 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525Ab3HUEBd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 00:01:33 -0400
Received: by mail-pa0-f45.google.com with SMTP id bg4so305963pad.4
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 21:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=CIp05eaxA3fRUxkALf3T/0u7pZ+7QVg4hvzKVlOvQ6w=;
        b=IRYh5rEGH2Q33DIgJGxL3g8hUSKwgqCGnjpgifTLuXlnEWOV/baUhCZmr2Cj+HCVhg
         7UzjnXcVRQsmsp6HrEt3zKw4Bmfjy4vr+X6hxw9Hb6WOEAfi3aKEORZWXRGRNaSkrFtf
         XiYB334tFtsbY1gMkNLvUEPtBVnPUex8zNL5xL7bNoRWTUR0Bmc2AEdSTbR6/Byj9B37
         lnnMNmIpvBS6Dqzyrj5qlJgJHk3erPDMZgyKymnkCh96aj2eN1UP29uxzfHwxmKqB7Ey
         frXkFu5x2kTUpzEuBO756/IBVajTxMow43+6Fu0g+uNmWDWkdtQuRRYAPhdEz5FSabCk
         SsYg==
X-Received: by 10.66.171.13 with SMTP id aq13mr7436492pac.30.1377057693370;
        Tue, 20 Aug 2013 21:01:33 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:7e6d:62ff:fe8c:90ce])
        by mx.google.com with ESMTPSA id t9sm5456904pba.46.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 21:01:32 -0700 (PDT)
In-Reply-To: <CACsJy8A_gJXUm2WVPCXDZbWFCusvyoEUJaGJT_ROC9uzxc_A6w@mail.gmail.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232685>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Aug 19, 2013 at 2:42 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> Respect a GIT_INDEX_VERSION environment variable, when a new index is
>> initialized.  Setting the environment variable will not cause existing
>> index files to be converted to another format for additional safety.
>>
>> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
>> ---
>>  read-cache.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> There should be a line or two about this variable in git.txt, section
> "Environment variables". We could even have core.defaultIndexVersion
> for people who don't want to set environment variables (and set this
> key in ~/.gitconfig instead) but this is not important now.

Ok, I'll add it in git.txt.  I agree, core.defaultIndexVersion can still
be done in a follow-up patch, the environment variable is the important
thing now because it's used for testing.  Existing repositories have to
be converted with git-update-index anyway.
