From: Stefan Beller <sbeller@google.com>
Subject: Reviews for the first patches of pclouds/narrow-checkout
Date: Mon, 23 May 2016 11:26:16 -0700
Message-ID: <CAGZ79kb-y6gUHEBSdVB6Y+A=EjykZgcNsLynXcwSMyVNHiDU2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 23 20:31:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4udd-0003Gw-S5
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 20:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868AbcEWSbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 14:31:34 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:36490 "EHLO
	mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbcEWSbd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 14:31:33 -0400
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 May 2016 14:31:33 EDT
Received: by mail-it0-f44.google.com with SMTP id e62so36455732ita.1
        for <git@vger.kernel.org>; Mon, 23 May 2016 11:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=YZyLJHaF54ZuTl1KY7zDDT2P5Ayn9T20qAnnznLEJng=;
        b=Z7imQ5A7uYx5PdBn3PE5WsLkthTeg5i3sQpeusUdsyTnx5MJLvvZq3c9nRcskyLvQp
         CpUqjlhZGPzxbWVklxw0b0LpZyofPyvTRjUC86J4JVivL+v6XEFuZ5z060QNf0uDKKyc
         14EJB3EVcptQm1HlQXPs8Q60PKod3ffzi13Z3Xe5VXsfGcy5B/8k5xjKXN+cvKpOKvD6
         yMDliCy0EJB5eS/JfMWV27gQ6bazh83lSoVNW0PW0UdLPsKUYl4kOwBkGKmoTGQe5x5v
         kTHHa28wGqqYMHJC9mpm8j+pYxY/OeeXBPZUD3nBnfKpBSpwlYUdxI+Lxdds5SuNYpkV
         oE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YZyLJHaF54ZuTl1KY7zDDT2P5Ayn9T20qAnnznLEJng=;
        b=bhfgAhsBV2RFa+/pZ0/OJpNV/1OcCvhhsy+4wt4ZQ9BKMCX2QpnYzRDQp5wk7oGnLi
         Xo5voU/ifDht5OYOPSA0jxn+YHqIibwF4ujRr9Ny/NvEP8H1jiNmI0m3WLXvzPmQeeIU
         LBneWhzdvLG1WBxsBOfuVNjdpQkxSyfoWRO4VvLFQ76b2WyLlqfmGqwd3yEyr1tlOHho
         h3nFbx3bRa/TXOoQtKKi3lRdyxyOzC0b7V8QJKbYQs6ttL+AG3iFDlG1kzbsztJCqMYG
         BpIjC2f//xJTPTE/BFoiFOqYPCdJxyo7qnxj7JtYtBUaA8U7ibpPUSMkNygO41CVy4bU
         7qdA==
X-Gm-Message-State: AOPr4FVsCUQrSqAycxE5OYZJo6H0ehLcBaZpE71f1RLf8+NJ5oK/MSxC0gVNA55yHSOMBJ24s9nXqmrUplW+4ou/
X-Received: by 10.36.14.71 with SMTP id 68mr13727741ite.98.1464027976773; Mon,
 23 May 2016 11:26:16 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 23 May 2016 11:26:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295347>

Hi,

so I started looking into your narrow checkout branch and started reviewing
the patches. Thanks for working on the narrow checkout!

Reviewed-by: Stefan Beller <sbeller@google.com> (just asking for signoff)
    tree.c: break long lines
    read-cache: realign some statements
    read-cache: add sort_index()
    read-cache: description for base_name_compare()
    unpack-trees: break down long lines

Regarding:
    base_name_compare: do not assume name[len] == '\0'
Could you clarify if this is an existing bug or a preparation for a future
different use?



    read-cache: new sort compare function that pays attention to ce_mode

Would a new mode (0100 (directory)) require bumping the index version?
Or the other way round: What If I use these patches and then try to use
another version of Git without this feature?



    read-cache: refactor check_ce_order()

Would it make sense to avoid the yoda condition?
(i.e. "cmp > 0" instead of "0 < cmp" -> die("unordered stage entries"))
Or rather: I found it confusing that cmp is on both sides of the < in two
different conditions, i.e. it looks like you prefer to keep the "<" sign
constant, whereas I would have written

    if (cmp < 0)
        continue;
    if (cmp > 0)
        die(...);

It's a style thing, so I guess either is fine.
I would however put the case for (cmp < 0) first as that is the expected case?



    read-cache: check ce_mode in check_ce_order()

    Can we replace
        cmp = (c1 < c2) ? -1 : (c1 > c2) ? 1 : 0;
    by:
        cmp = c1 - c2;
    as it is only used in comparisons lesser/greater than 0 afterwards.

Again, I would put the "continue" case first (cmp >0)



    read-cache: index_name_stage_pos() => index_name_mode_stage_pos()

"After this read-cache.c code is pretty much ready for accepting dir
entries in the index."

What is missing?


So that's a review for the first third of the patches. :)

I wonder how much is left for actually finishing the narrow checkout,
as I could not find documentation or code the user interacts with.
(i.e. I would like to use a narrow checkout. How do I start? Where do I put
the pathspec of things I would like to use? Or are you envisioning a git wrapper
for that? "git narrow [make-go-away, revive] <pathspec>" ?)

Thanks,
Stefan
