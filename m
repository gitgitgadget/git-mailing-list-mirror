Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E0BC433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 14:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350785AbhKXOgg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 09:36:36 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:51292 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356053AbhKXOg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 09:36:28 -0500
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mptKk-0004LC-67; Wed, 24 Nov 2021 14:33:15 +0000
Message-ID: <bf9b547d-f421-49f7-9dc5-cc1f81187127@iee.email>
Date:   Wed, 24 Nov 2021 14:33:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 8/8] dir: avoid removing the current working directory
Content-Language: en-GB
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Glen Choo <chooglen@google.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
References: <a5528cbb14ddbbf26cde873e3f3e95744d59b950.1637455620.git.gitgitgadget@gmail.com>
 <20211123003958.3978-1-chooglen@google.com>
 <CABPp-BE0Bcimwr1wwcnnh+6apx7r114Oqnu=QDgKEn6VAHAtFg@mail.gmail.com>
 <kl6lmtluka55.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CABPp-BGr9PDTE0q5zev4Ffx19g+hG083zdNShoSdH47VqzT8mw@mail.gmail.com>
 <211124.86ee76e4fl.gmgdl@evledraar.gmail.com>
 <CABPp-BGZPheDqWD1pXbePOYe2BcT1-TqX-zGVqnNLGtFuXab1g@mail.gmail.com>
 <211124.86wnkxdbza.gmgdl@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <211124.86wnkxdbza.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/11/2021 11:14, Ævar Arnfjörð Bjarmason wrote:
> I'm not concerned that you didn't research this change well enough, I
> just find it a bit iffy to introduce semantics in git around FS
> operations that don't conform with that of POSIX & the underlying OS. My
> *nix system happily accepts an "rm -rf" or an "rmdir" of the directory
> I'm in, I'd expect git to do the same.
Isn't this the same, conceptually, as trying to remove the root
directory, but from a Git perspective?

i.e. Something along the lines of
https://superuser.com/questions/542978/is-it-possible-to-remove-the-root-directory
(their answer is 'no' without a special option, default since 2006)

If I read the arguments correctly, Elijah is saying that Git shouldn't
delete it's own root (cwd) directory, and that it is already implicit
within the current Git code.

Philip
