From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] send-pack: don't send a thin pack when the server
 doesn't support it
Date: Tue, 8 Oct 2013 15:22:15 -0700
Message-ID: <20131008222215.GI9464@google.com>
References: <1381221884-27048-1-git-send-email-cmn@elego.de>
 <CACsJy8AQ-719sbUfJW98q_HYit7ePfB6oN3v7XTX6fvC7HnixA@mail.gmail.com>
 <CACsJy8AHAbDuz3yhsjJfRQUGg1zzx6qqoAf=1oNhbX1xPVithg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 09 00:22:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTffn-0001iY-S5
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 00:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755505Ab3JHWWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 18:22:20 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:33788 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754057Ab3JHWWT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Oct 2013 18:22:19 -0400
Received: by mail-pb0-f52.google.com with SMTP id wz12so9295025pbc.11
        for <git@vger.kernel.org>; Tue, 08 Oct 2013 15:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RU8sv5HW4RxdlfDDVGg2J99i77mQyJciYt0mRPBBZZM=;
        b=FWvaaGjWV1L7L1CoezDQsNkkEOfxOV6D+ntlDPrPC/KPbXXvfeP49BKWQ8xSB0bej5
         r+GM1ZAX710pvC6g67rpnpPyUPqx/56EFUnUTd3OfKN4NPkXKKtQdgPW2Xxtk3iPFlqx
         VTCwF384NWIwu5fr1Y2ojbPye1hslyKcow1EE0q6m8/L+sQcx+KNFRFLirFhkeVMzZBj
         zJdtxXhzQMZqTKUpWj6kUHhoh7EsoFcuIZ+Ci+XE9zg+R+WjhdA4E5ASQlEe24JdotbR
         avx3SLc0hFSJk+OQVbUraeCBLjVK8bIWotjDQ4yz239KNSq0dv9ouTCCJ1KF8q/urIHp
         +GsA==
X-Received: by 10.68.219.104 with SMTP id pn8mr4349120pbc.81.1381270939189;
        Tue, 08 Oct 2013 15:22:19 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id im8sm42325368pbc.24.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 08 Oct 2013 15:22:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8AHAbDuz3yhsjJfRQUGg1zzx6qqoAf=1oNhbX1xPVithg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235797>

Duy Nguyen wrote:

> Or maybe it's not that late. How about you go with your patch and add
> thin-pack capability to receive-pack too?
>
> When new "git push" is used against old server, thin pack is disabled.
> But that's not a big deal (I hope).

Could we have separate patches to introduce the server-side capability
and then to request it in the client?  That way, people with old
servers can apply the patch introducing the capability if they want.

The new meaning of the "thin-pack" capability should also be
documented in Documentation/technical/protocol-capabilities.txt.

Done that way and with enough time between the server advertising the
capability and the client looking for it, it seems like a good idea.

My two cents,
Jonathan
