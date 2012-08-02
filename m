From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 04/16] Modify write functions to prepare for other index formats
Date: Thu, 2 Aug 2012 19:22:58 +0700
Message-ID: <CACsJy8Av_ODO--DAsznP8R6DnOP_GQXKxVQDKeVYg=E3mZUnEQ@mail.gmail.com>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com> <1343905326-23790-5-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 14:23:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwuRC-0003I7-Lu
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 14:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415Ab2HBMXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 08:23:30 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59627 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133Ab2HBMX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 08:23:29 -0400
Received: by yenl2 with SMTP id l2so8614329yen.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 05:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ccgpfWhCatWAhKeaDre5xVgyd0Hwb0/0dKePbS2QJl0=;
        b=LqsMSo5sp2G78Mrrp3OESbqItCakJQyNG09ED4bwhwD2uyF0Y4cOw59YO6fUxYAkUQ
         46MovQHCDV4+BsN5rKxpDvfkYhd2K/4NTgOzH1qSI3DBLdyoX+XJefQ97Z8O9MijEQeU
         3Z2xUvDrJACqbyco+9SGe4ogVouD5z9prQw4qhWA2EmOtXT1KHrP+Ur/UyzWEvcCkHxB
         +RGD2mcVfWstksEIILAmnDdikAIf7vWkBTlqEao+//+KUad4acfrux2NTXGMEFdFcpEG
         MLlfLc8JRZTCvHQ9pqzHERu2+TRwWG7tpKWno1UfTxdpNxeKhSgd9j9BVkVjlJbWVXLk
         +VkA==
Received: by 10.50.100.129 with SMTP id ey1mr3263897igb.35.1343910208703; Thu,
 02 Aug 2012 05:23:28 -0700 (PDT)
Received: by 10.64.90.2 with HTTP; Thu, 2 Aug 2012 05:22:58 -0700 (PDT)
In-Reply-To: <1343905326-23790-5-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202772>

On Thu, Aug 2, 2012 at 6:01 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> @@ -1785,7 +1785,7 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
>                 rollback_lock_file(lockfile);
>  }
>
> -int write_index(struct index_state *istate, int newfd)
> +int write_index_v2(struct index_state *istate, int newfd)
>  {
>         git_SHA_CTX c;
>         struct cache_version_header hdr;

make it static function too (and read_index_v2 too, I think)
-- 
Duy
