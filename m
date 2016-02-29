From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v6 7/7] git: submodule honor -c credential.* from command line
Date: Mon, 29 Feb 2016 15:44:51 -0800
Message-ID: <CA+P7+xrr61wO0XrhXCEbSLPbSo7HxxzDWnq=6K14fvyo7RfscA@mail.gmail.com>
References: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
 <1456786715-24256-8-git-send-email-jacob.e.keller@intel.com> <CAGZ79kbDaV=i0augzh5RgGYpTWXOuTLx=7Occhc-6iE+0pBVNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 00:45:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaXVc-0005lx-7c
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 00:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbcB2Xpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 18:45:43 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:34686 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789AbcB2XpM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 18:45:12 -0500
Received: by mail-io0-f175.google.com with SMTP id 9so201114413iom.1
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 15:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AP1ss6JjxqLaLZulMvgfCwWD83QlG7o95/ixiWI3F2I=;
        b=QDW1ErdiDP7Z8UzVpES9T/efW9t9kcc2cFyaPWyR68oYUn6nDiLmXJ0eNsZCOkvJIv
         vGxVi6T7t1/sgP0REQUZj3eXS4U8J/PHlUlvWKVIhgcA4x61tJOHYo5N6HRbMBUuxxuv
         xQYZQKJA5mMiVf3RUKk3oPxt4Y6Ow7dCczinqY+CCwJfTdjaUDzx0MrrGcT142lhRng/
         bjOjO7pISegBLIU2TsOjZf62JA/x6x+jDho+Bvz3YUohmMrYcbJUZa4cJNOZK0K+eaAu
         gMK+4ex2LDWEevP1ANIVT69syG/FjfuBmxe34FlppTPRCVMxaSYe+0IBpWbblbxox1qp
         sLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AP1ss6JjxqLaLZulMvgfCwWD83QlG7o95/ixiWI3F2I=;
        b=Bu8+Y68bgtarsbvDhs42rCvVBCLHJwyYqWKXHRJikjX+lg1rAYGidzvpoTw9G/5aPg
         V0mHot+fMZJrE2Cn48W7tiEQN1zd1S1+Gvh6djbZSfY7I7dLgenr9K5dGFNSnC/SatzK
         MqJaxtHxulk5DzIUGGmHI6zel1zGWnq1DfeFw30270dNWXe668Hvc4n6d6jiaavVimWL
         ztnDEHwvcNL+j+ER/6lyoujaQ/ek3h57wvy2ySSDoP9k3npzvNDKv38/du5xJKKVZYFQ
         FzfjSAPJ4dqBUoZ2/lDzlDVIHHDSqRJa5ki7Y26ajJ1If2CW/oKUioFZ73zgBBg4IJe9
         tc4g==
X-Gm-Message-State: AG10YORTbvg7w94jcgg4h8itB0QGcjhReyssiWY8HY4KiJSC2Rhb0WL7Owl6BP0C43S00ZuHulWMvH41PPfS3A==
X-Received: by 10.107.166.195 with SMTP id p186mr22025813ioe.146.1456789511000;
 Mon, 29 Feb 2016 15:45:11 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Mon, 29 Feb 2016 15:44:51 -0800 (PST)
In-Reply-To: <CAGZ79kbDaV=i0augzh5RgGYpTWXOuTLx=7Occhc-6iE+0pBVNg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287941>

On Mon, Feb 29, 2016 at 3:39 PM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Feb 29, 2016 at 2:58 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>>
>> +test_expect_success 'cmdline credential config passes into submodules' '
>> +       git init super &&
>> +       set_askpass user@host pass@host &&
>
> I wonder why we use pass@host as a password, it seems confusing to me.
> p@ssword would have worked if we wanted to test a password containing an @,
> pass@host doesn't quite fit my mental model of how passwords work.
> No need to change anything, better be consistent with the rest of the tests.
>

I am not sure, but I don't think it particularly matters what we use.
Most of this is pretty much copied as suggested by Peff.

>
>> +       (
>> +               cd super &&
>> +               git submodule add "$HTTPD_URL/auth/dumb/repo.git" sub &&
>> +               git commit -m "add submodule"
>> +       ) &&
>> +       set_askpass wrong pass@host &&
>> +       test_must_fail git clone --recursive super super-clone &&
>> +       rm -rf super-clone &&
>> +       set_askpass wrong pass@host &&
>
> Why set set_askpass a second time here?

Interesingly, it fails unless I add this line with:

Submodule path 'sub': checked out '678c534310f3cd5727f8e066cba0cd420bd7948e'
--- "/home/jekeller/git/git/t/trash
directory.t5550-http-fetch-dumb/askpass-expect"     2016-02-29
23:43:35.724179569 +0000
+++ "/home/jekeller/git/git/t/trash
directory.t5550-http-fetch-dumb/askpass-query"      2016-02-29
23:43:35.681179568 +0000
@@ -1 +1,3 @@
+askpass: Username for 'http://127.0.0.1:5550':
+askpass: Password for 'http://wrong@127.0.0.1:5550':
 askpass: Password for 'http://user@host@127.0.0.1:5550':
not ok 13 - cmdline credential config passes into submodules
#
#               git init super &&
#               set_askpass user@host pass@host &&
#               (
#                       cd super &&
#                       git submodule add "$HTTPD_URL/auth/dumb/repo.git" sub &&
#                       git commit -m "add submodule"
#               ) &&
#               set_askpass wrong pass@host &&
#               test_must_fail git clone --recursive super super-clone &&
#               rm -rf super-clone &&
#               git -c "credential.$HTTP_URL.username=user@host" \
#                       clone --recursive super super-clone &&
#               expect_askpass pass user@host
#

I really don't understand why adding the extra askpass setting fixes
this? Possibly because the query and expect files are appended to? Or
something else subtle going on?

Basically: without this, the expect vs the query don't match. With it,
they do. I don't understand the reasoning why.

>
> Thanks for this test!
> Stefan

Jeff King suggested it, originally.

Thanks,
Jake
