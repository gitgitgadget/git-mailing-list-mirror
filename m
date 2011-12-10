From: Ivan Heffner <iheffner@gmail.com>
Subject: Re: process committed files in post-receive hook
Date: Sat, 10 Dec 2011 04:06:35 -0800
Message-ID: <CAF_oF=yHGFs0TiXkbdoNFxXk2w8TcKSoYx2ZkiOQyYzgYHmxSQ@mail.gmail.com>
References: <loom.20111210T111457-837@post.gmane.org>
	<4EE340D2.200@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Michael Schubert <mschub@elegosoft.com>, Hao <billhao@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 13:06:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZLhR-00060g-Td
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 13:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883Ab1LJMGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 07:06:37 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40534 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab1LJMGg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 07:06:36 -0500
Received: by iaeh11 with SMTP id h11so146061iae.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 04:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9h5upEKV9ZaLqDLJ9E0W0zytGoQi/KCDxfsD6AsJO6Q=;
        b=Hv2ZRnU/vTU3fYwlJdTlxjb/55B+VNXv9wqh31ZVrymjmpXxXQV4AQKotm1RTmtm9S
         qzDkVGWl/tPT/5nym0QHvBFtkYsE1VrxOXZHHiyzMc/XFld73x+ldTurvYJ9WJ8R/d4H
         FSdgmEiFRf4UsB5gVTOu+yr2DmA4vHRvQhhho=
Received: by 10.50.160.201 with SMTP id xm9mr7397379igb.9.1323518795765; Sat,
 10 Dec 2011 04:06:35 -0800 (PST)
Received: by 10.231.169.71 with HTTP; Sat, 10 Dec 2011 04:06:35 -0800 (PST)
In-Reply-To: <4EE340D2.200@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186764>

On Sat, Dec 10, 2011 at 3:21 AM, Michael Schubert <mschub@elegosoft.com> wrote:
> On 12/10/2011 11:29 AM, Hao wrote:
>> I am writing a post-receive hook in Python that examines the content of some
>> files (the HEAD rev). Because the repo is a bare one on the server. My current
>> approach is to check out a working copy on the server and run 'git pull' in post-
>> receive to get the most up-to-date version, and then process files in the
>> working copy.
>

You can actually use a combination of git ls-files and git cat-file -p
in order to list and look at te content of files on the remote without
checking out an entire working tree.
