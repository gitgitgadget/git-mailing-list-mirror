From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Clone fails on a repo with too many heads/tags
Date: Mon, 19 Mar 2012 08:30:38 +0700
Message-ID: <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com>
References: <loom.20120318T083216-96@post.gmane.org> <m3fwd550j3.fsf@localhost.localdomain>
 <20120318190659.GA24829@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Ivan Todoroski <grnch_lists@gmx.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 02:31:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9RRM-0007Im-36
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 02:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757365Ab2CSBbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 21:31:11 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:37349 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756673Ab2CSBbK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 21:31:10 -0400
Received: by wgbdr13 with SMTP id dr13so673045wgb.1
        for <git@vger.kernel.org>; Sun, 18 Mar 2012 18:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=f+MNep3PPf6m7TDsZvp4cIaGG80v1SKnlvytmEv/K/I=;
        b=krY1zNhFEYca15YFIRTWUC7Xe0LPkedL5ilzTDx4VjC5kQ7nXo4EY+a5eJ7ZU36Soe
         cvAdRuxMF8xL9KL2dxCiSqLaaaYPTdBVzHQwHkB7p6huh0f50FzXck9DtxQXH6IKofMF
         KXP07p3XPYHDQG+CUAwPsZ7ycGbUk87vvPsVVumVv6zrksVYi4vNjuXON6MXW2CuaMFP
         Xijb+RB7uWMt3YRvwviA3KMAWGv0ndHSIavIslHqj7DZmO6o8LTU7KjvVPSv/p8mKUeo
         zJtLcpSJKklKfSllOreLfeo++k+EMuMsBjjdMZA+1fs8cKVYIlCY1dUTwRLNIdHyOR+Y
         33tg==
Received: by 10.180.102.102 with SMTP id fn6mr15710197wib.10.1332120668644;
 Sun, 18 Mar 2012 18:31:08 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Sun, 18 Mar 2012 18:30:38 -0700 (PDT)
In-Reply-To: <20120318190659.GA24829@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193408>

On Mon, Mar 19, 2012 at 2:07 AM, Jeff King <peff@peff.net> wrote:
> I don't think that will work, as stateless-rpc fetch-pack already uses
> stdin to receive the list of advertised refs from the remote. Nor would
> you want to have multiple invocations of fetch-pack, since that would
> mean multiple http requests and multiple pack responses (which could not
> delta between themselves).

remote-curl functions as middle man between http client and
fetch-pack. Can we just send ref list over fetch-pack.stdin first,
followed by maybe empty line, then normal stuff that remote-curl feeds
fetch-pack?
-- 
Duy
