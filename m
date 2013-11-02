From: Gerasimos Dimitriadis <gedimitr@gmail.com>
Subject: Question on merge order
Date: Sat, 2 Nov 2013 03:11:55 +0200
Message-ID: <CAM3f4mDXwXTJ5Kq3sgyK7yDLsBTdxSJXkZdE-SBe2LqfM3fccw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 02 02:12:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcPlC-0002Dk-V2
	for gcvg-git-2@plane.gmane.org; Sat, 02 Nov 2013 02:12:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680Ab3KBBL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 21:11:57 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:54694 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894Ab3KBBL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 21:11:57 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so4006095lbh.35
        for <git@vger.kernel.org>; Fri, 01 Nov 2013 18:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=gJkxJs9E8v2AHcTPa/QmsHKhwTER9EbRkMMLBbA+4ag=;
        b=FjLk62Nip0w/jz1ACZUSqzqTq0YCdGt7NnNRkNcy6igtjnFwvZbf5YCo8VpwA/yW0M
         ms2nf+d/X4YGRpcEpdYptw848RuBWe5cKKjUbKP+IHpvtYsT3wukarmqvLN7TiN3rZwz
         gtF7YMJs+4cz3r7rur31a0ke0vgo8BZ2Tv4n4SDWeWrrrucjETR7Vf8CRBYKNkqE8M8S
         ZD1w4u5MTibxnup4MfLAe4maZwYUbtTsYLKN98BF1yoVlu2ewGK08MO3FQ348xbryNGW
         C8sNMlaejsyIAUKOqTXJE5QKNtw5VVUIBf5+bXwrGDHQIyQonoKNqEaEiSLdWD9Udy57
         tihw==
X-Received: by 10.112.171.228 with SMTP id ax4mr3281215lbc.6.1383354715388;
 Fri, 01 Nov 2013 18:11:55 -0700 (PDT)
Received: by 10.112.24.34 with HTTP; Fri, 1 Nov 2013 18:11:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237233>

Hi,

I have a question on the order with which commits are applied on a merge.

I am merging two branches that have changes on the same text file and
I'd like to ask you about the merge result.

The following output is provided on the two branches to be merged, by
the command:
git show-branch --date-order branchA branchB

! [branchA] file.txt got form A
 * [branchB] file.txt got form B
--
+  [branchA] file.txt got form A
 * [branchB] file.txt got form B
+  [branchA^] file.txt got form B
+* [branchA~2] First version of file.txt (form A)

Now, this text file alternates between the following contents:

According to form A, file.txt contains only one line of text:
Gerasimos

According to form B, file.txt contains three lines of text:
PL-3
PL-4
PL-5

The merge is done with the following commands:
git checkout branchA
git merge branchB

Now, the result of the merge gets file.txt to form B, i.e. it contains
the above 3 lines of text.
My question is, why does the merge have the file resolve to form B and
not to form A ?
Theoretically, the merge could resolve to either A or B form. If the
date is taken into account, maybe the A
could even appear to be a better result.

Thank you in advance and BRs,
Gerasimos
