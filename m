From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] worktree: add: introduce --checkout option
Date: Thu, 24 Mar 2016 16:16:36 +0700
Message-ID: <CACsJy8DxcqYKrRi7_ERS3xLWfbbq3bNx-u2NWiXYoNw4yD+0dg@mail.gmail.com>
References: <01020153a40588f3-5401ea3e-ece8-435c-a046-a5c1c1f92cd6-000000@eu-west-1.amazonses.com>
 <01020153a73bbb70-11a8482f-1a90-49e4-a56c-b311e12a85a2-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Ray Zhang <zhanglei002@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 10:17:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj1OE-0000Jl-4q
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 10:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302AbcCXJRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 05:17:10 -0400
Received: from mail-lb0-f194.google.com ([209.85.217.194]:35218 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbcCXJRI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 05:17:08 -0400
Received: by mail-lb0-f194.google.com with SMTP id oa3so2695107lbb.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 02:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Kt09zN/Vc3gXvKq/n0jWLTduFi2fDCjxudp6fePkRmc=;
        b=W1HhjtcZSQQJYOf2OsHUDBPPyUSaul1wMeQvclHWXwRGDk6ZLbeodDMnafUOgN8uLm
         mrHs4CJvHGyMhJw6BHkoHGInui40riHqOOZGV132Su8dmBIa1UptEpSShblBkWC2nX39
         Rznqf/M4GzYLNQ7nTER7qqOiWIWdhEawMImymjzZ9pHxX7Kn/ZGq7GiAkOb3/J8ZvhpQ
         PR4FPY7MTw6nyAnLvpqtEJNcC5XTQOFXXMXfUugVyIUUf2G+HjGWURFQzP2Of7/3X18I
         bQ28/fvIpvVzhH6K6fMWrzusl4KCuOaepUbnEOFyArZzcTGmnf4h6vN33nTaemdn/45p
         OrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Kt09zN/Vc3gXvKq/n0jWLTduFi2fDCjxudp6fePkRmc=;
        b=PO+dyqLmetBFTGXzND5IePkQPI35G8mh1+yXQxCTzRMIZbsUjD27i6SANuAARbI64g
         E10EBACNCge4x1IKzmKqjIHZMQYZLG/EDwP2wxyLZzXzJbJ4R6a9YfXHipJ880D3zgRK
         17vbDcdjf4dyKOLXj03dQ/2PZSeIO6RKruwrSgFsL+Xl5cK1YbzCnn/LKwc6n0/jSKKc
         +ydgCP/rWr99m1xrntoWfrXC/E7voGOOT9JXA/eAwygnIt01bj0SVgtbBfqo+StTUtml
         MeR0zifbmFkGywueHZG/Jnt2JfWsPlSDyGKbB3ieAvU1xxhvzy3mlCT5aGIZDY5ev+lS
         N50g==
X-Gm-Message-State: AD7BkJIIRXwLQxiYP4NpIbrwVO94orf19bj3wNE1EH7ULMCr1gROrcQN/J8f7560mAcggiW7szPamZIKRkb6Fw==
X-Received: by 10.112.54.132 with SMTP id j4mr2951990lbp.3.1458811025711; Thu,
 24 Mar 2016 02:17:05 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Thu, 24 Mar 2016 02:16:36 -0700 (PDT)
In-Reply-To: <01020153a73bbb70-11a8482f-1a90-49e4-a56c-b311e12a85a2-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289727>

On Thu, Mar 24, 2016 at 1:07 PM, Ray Zhang <zhanglei002@gmail.com> wrote:
> By adding this option which defaults to true, we can use the
> corresponding --no-checkout to make some customizations before
> the checkout, like sparse checkout, etc.

I think we can follow git-clone and use '-n' for this. But if it's
sparse checkout that's you're after, be warned that it's not fully
supported (you either enable sparse chekcuot for all worktrees, or
none).
-- 
Duy
