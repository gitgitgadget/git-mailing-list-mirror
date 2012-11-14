From: "Jack O'Connor" <oconnor663@gmail.com>
Subject: Re: Bug? Subtree merge seems to choke on trailing slashes.
Date: Tue, 13 Nov 2012 18:17:03 -0800
Message-ID: <CA+6di1nsWOGXjchOc3SZ2FL79zGzgNqjOJyN0zf8Yb8GbXCpbA@mail.gmail.com>
References: <CA+6di1m7OCMjahP9sN3NcYdxLRRi4vmttFa5=pnHrgKp=E4+jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 14 03:18:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYSYg-0001fD-0M
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 03:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356Ab2KNCRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 21:17:35 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:39707 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932318Ab2KNCRe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 21:17:34 -0500
Received: by mail-la0-f46.google.com with SMTP id h6so5957128lag.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 18:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=YdyeaqWc4LXGdYMhfk5oH6tB4luG1qsWci4tjr95wdw=;
        b=O08ZhylZlYcEFePJhJfLr/Z31hz6WSbw5zvRyc0tS7iY2OnUb0IX/XvqptQ6tV4hlE
         SA66CQBLLi4evhgte/VD47jKC7K0o6E1KPXOpv7gpCBHUeOgNibb2ZyGVT7rxWXc3rEF
         FSpL+OQhyqLlneh5NYLAk4+v7OnOxbrvUpfPxietko33kb2/bEXp3Gibtji446O86ly4
         W61FhmNwhRgFmZSjxuHYjLjTdEYVNhNcgYYC3nrq/FV6kPAUWOR7FSHU4SObgkVYMch3
         oAffMWiiSMM/PJ0CWlHr6t1f3aCmS8dehu05TdCefDg2LLXhoF9tHyPCH1MeGIclXAJU
         uYmg==
Received: by 10.112.31.194 with SMTP id c2mr9684547lbi.44.1352859453311; Tue,
 13 Nov 2012 18:17:33 -0800 (PST)
Received: by 10.112.38.105 with HTTP; Tue, 13 Nov 2012 18:17:03 -0800 (PST)
In-Reply-To: <CA+6di1m7OCMjahP9sN3NcYdxLRRi4vmttFa5=pnHrgKp=E4+jQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209693>

Do I have the right list for bug reports? Apologies if not.

On Tue, Nov 6, 2012 at 5:58 PM, Jack O'Connor <oconnor663@gmail.com> wrote:
>
> I'm summarizing from here:
> http://stackoverflow.com/questions/5904256/git-subtree-merge-into-a-deeply-nested-subdirectory
>
> Quick repro:
> 1) I do an initial subtree merge in what I think is the standard way
> (http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html).
> My prefix is simply "test/".
> 2) I try to merge more upstream changes on top of that with the
> following command:
> git merge --strategy-option=subtree='test/' $upstream_stuff
> 3) Git fails with an obscure error:
> fatal: entry  not found in tree daf4d0f0a20b8b6ec007be9fcafeac84a6eba4f0
>
> If I remove the trailing slash from the command in step 2, it works just fine:
> git merge --strategy-option=subtree='test' $upstream_stuff
>
> Note in the error message above, there's a double space after "entry".
> Is it looking for a tree with an empty name? Did my trailing slash
> imply a directory named empty-string?
>
> Thanks for your help.
>
> -- Jack O'Connor
