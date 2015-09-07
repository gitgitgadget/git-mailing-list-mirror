From: Levin Du <zslevin@gmail.com>
Subject: Re: Questions about git-push for huge repositories
Date: Mon, 7 Sep 2015 09:05:41 +0800
Message-ID: <CAN6cQGMf089ERn2kZbFpHJ6vyJ4BnjCm-m-E+hQsduH55XFvKw@mail.gmail.com>
References: <CAN6cQGPcGpaXUGu_7aaeJtMbruMocte-5po97vG5r39f=YdTZQ@mail.gmail.com>
	<xmqq4mj7bfsf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 03:05:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYksf-0000mR-0y
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 03:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbbIGBFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2015 21:05:44 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:36686 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915AbbIGBFm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2015 21:05:42 -0400
Received: by vkbc123 with SMTP id c123so35537361vkb.3
        for <git@vger.kernel.org>; Sun, 06 Sep 2015 18:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Wyg5szUpbDHLMp9LzM+UVOV59VE0UOJT/Mi136H/Z3A=;
        b=cXb+5Rn4osXU0SiNzoJ/zbY0Tr8Gbql2UJ7TWudt1HOtbJNQbdOXSRoxYRmrkFcY6A
         PcSK1N9bmqxn7t3ADkNq+BZW/1WCHGjQULK0KNA6sH+6yKnnPe0np6O34DcyZSQ5pVln
         rrVpU7f4uJWS2PIN7moF0jXbE9mtZiKhfuFoI1rcro2sEaCmrilkTK6VssRQ7gzwTndP
         J5YXYfzK6XRzB1xdkaraIFNaEL9dDX1KMpTFx0vVGLM4UOou/5UHRygpcIx62ED7aBoU
         xMqyWXigy9Esc+KvacnKbfN5Cxk17fLDy0G0EC23agD0OD3AOEYehrU1VL21SYQtXXX9
         Pn1Q==
X-Received: by 10.52.184.163 with SMTP id ev3mr21647871vdc.63.1441587941783;
 Sun, 06 Sep 2015 18:05:41 -0700 (PDT)
Received: by 10.103.85.138 with HTTP; Sun, 6 Sep 2015 18:05:41 -0700 (PDT)
In-Reply-To: <xmqq4mj7bfsf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277442>

> Instead, the object transfer is optimized by comparing what commits
> each side has and sending trees and blobs that are reachable from
> the commits that the receiving side does not have.

The sender A sends all the commits that the receiver B does not have.
The commits contains trees and blobs. In my situation, branch in A has
only one commit. It seems that B has received lots of duplicate blobs,
concluded from the GC result.

What I do not understand is, how duplicate blobs happen in a git repository?
Git repository is famous for its content addressing storage system.
I guess that A sends its packed file to B directly, no matter what are
already in
B.
