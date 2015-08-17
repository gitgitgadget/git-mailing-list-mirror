From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2015, #03; Mon, 17)
Date: Mon, 17 Aug 2015 16:38:32 -0700
Message-ID: <xmqq7fotbi4n.fsf@gitster.dls.corp.google.com>
References: <xmqqk2stbl3o.fsf@gitster.dls.corp.google.com>
	<CAGZ79ka6mz=f=g0mkgtP2955z+sRf1Sh+ArB=-ZA2ZhX27LuWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 01:38:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRTzH-0002Lt-KX
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 01:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbbHQXih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 19:38:37 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:36654 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbbHQXid (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 19:38:33 -0400
Received: by pdbmi9 with SMTP id mi9so20269883pdb.3
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 16:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=3+bc3Ahs6jeqqi+y9EGyhl7TaXcmyKZPexZZivVMWjI=;
        b=LU0mmI7FDLGaU/ooAVSgxCGSP8yOaD1rF9PKBKVaqm7jtba8WqOizw7ZrVAkgpGHDs
         hZuDNlxDg4hzrq9wxXMyW98OLOkBjkd8SvihFB3JX89eEaPDn1tOA/+tqcOlcQcc0UXi
         VbnhwsjuFOpR2gNJ4mwuJhW44jsBeWzaZNS7uumHGQeewQo63uEJShFVA3ZDVf0KFy57
         PkccemR4U0cZXjg7SvLfPj0QibDt3+Be223UYNYDzcQIsqkFk/v/Pae4vRPw2GSQBYkD
         +d28mS4dYDwI7/+wPHyi1rYp9+43L8oFWBGyPiIEfzrM6vCnDUs7YX3a0whzLbHwOMqL
         8VRA==
X-Received: by 10.70.38.165 with SMTP id h5mr7315355pdk.164.1439854713413;
        Mon, 17 Aug 2015 16:38:33 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4db:7e94:b576:3da])
        by smtp.gmail.com with ESMTPSA id d5sm15874108pdn.74.2015.08.17.16.38.32
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 17 Aug 2015 16:38:32 -0700 (PDT)
In-Reply-To: <CAGZ79ka6mz=f=g0mkgtP2955z+sRf1Sh+ArB=-ZA2ZhX27LuWw@mail.gmail.com>
	(Stefan Beller's message of "Mon, 17 Aug 2015 16:28:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276105>

Stefan Beller <sbeller@google.com> writes:

>> * sb/remove-get-pathspec (2015-08-03) 1 commit
>>  - builtin/mv: remove get_pathspec()
>>
>>  Expecting a reroll.
>>  ($gmane/275224)
>
> IIRC the discussion turned out to expect a
> full conversion of internal_copy_pathspec in builtin/mv
> and not just moving all the cruft there, such that we can
> make the deprecated function non public and update the
> documentation.
>
> So I am not going to spend more time on that series,

OK, then will discard.

>> * jk/git-path (2015-08-10) 16 commits
>>   (merged to 'next' on 2015-08-12 at 7ebe864)
>>  + memoize common git-path "constant" files
>>  + get_repo_path: refactor path-allocation
>>  + find_hook: keep our own static buffer
>>  + refs.c: remove_empty_directories can take a strbuf
>>  + refs.c: avoid git_path assignment in lock_ref_sha1_basic
>>  + refs.c: avoid repeated git_path calls in rename_tmp_log
>>  + refs.c: simplify strbufs in reflog setup and writing
>>  + path.c: drop git_path_submodule
>
> Oops, I just wanted to add a caller to git_path_submodule. I'll also look into
> this series to see the alternatives. :)

I know.  

As you may be already aware by observing the tip of 'pu', I have
been queuing evil-merge resolutions to prepare your series for the
world without git_path_submodule(), so "looking into to see
alternatives" shouldn't be too huge a task ;-).
