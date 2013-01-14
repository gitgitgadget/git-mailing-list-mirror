From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: Announcing git-reparent
Date: Mon, 14 Jan 2013 09:03:31 +0100
Message-ID: <CAA01Csoh24ppo37fzptzZKvFrzGQyhz-0eDTQsP8tZiTRQ2YwA@mail.gmail.com>
References: <CAHREChhnf44CprHnS=z9KO5aOkfDPSG6Xb2GU=Kvaz38eTgbUg@mail.gmail.com>
	<20130114071608.GL3125@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Lodato <lodatom@gmail.com>, git list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 09:03:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuf1N-0001fn-8M
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 09:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754850Ab3ANIDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 03:03:33 -0500
Received: from mail-qc0-f175.google.com ([209.85.216.175]:55690 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab3ANIDc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 03:03:32 -0500
Received: by mail-qc0-f175.google.com with SMTP id j3so2318520qcs.6
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 00:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=eNh9+KzPJziYMEiM+scs/XqIZ63492K91Kq2u+Bbrz4=;
        b=iFMgiXTUc5ezH5hmUa7BgVbwCxgMqBB2FC9PjzyuQ7tWBmR1MkQFx/0Zyny5yvQE/D
         f8+ZciSJ+VyHzJq5It5cEybxxNL3UPky3oHaw3EbovltfRyK3nnKa0jmEdvNwr95kJXw
         +8JfPTFuje/D+xMEYDEff5AyiXgAj+RQmHTsUfPExsEn/KMBmPkCKbRXNfJCtNH5Q0Ht
         1YMX8vHeYGF2ExGVpG0kO4BUM3KOwoWUCwjUqx4TTdVGmvLYK+gS0JVCIcS2duq5ic53
         k1fUxgtH+CuDEKoHeoM/n2vYXLfJ6EIQPSuM5OYaYvt76+z62wt58YvtswsCfKxlMoi5
         gFrQ==
Received: by 10.49.3.234 with SMTP id f10mr83343387qef.52.1358150611571; Mon,
 14 Jan 2013 00:03:31 -0800 (PST)
Received: by 10.49.84.133 with HTTP; Mon, 14 Jan 2013 00:03:31 -0800 (PST)
In-Reply-To: <20130114071608.GL3125@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213470>

Hello,

On Mon, Jan 14, 2013 at 8:16 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi Mark,
>
> Mark Lodato wrote:
>
>> Create a new commit object that has the same tree and commit message as HEAD
>> but with a different set of parents.  If ``--no-reset`` is given, the full
>> object id of this commit is printed and the program exits
>
> I've been wishing for something like this for a long time.  I used to
> fake it using "cat-file commit", sed, and "hash-object -w" when
> stitching together poorly imported history using "git replace".

Just wondering, is the result different than something like

git checkout commit_to_reparent
cp -r * ../snapshot/
git reset --hard new_parent
rm -r *
cp -r ../snapshot/* .
git add -A

(assumes 1 parent, does not cope with .dot files, and has probably
other small problems)

--
Piotr Krukowiecki
