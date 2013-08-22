From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Document the HTTP transport protocols
Date: Thu, 22 Aug 2013 18:27:20 +0700
Message-ID: <CACsJy8A4c3gFeX+q4hPjki8+mLjv_xo4tNbhyyCcmaUX7tYFLA@mail.gmail.com>
References: <1377092713-25434-1-git-send-email-pclouds@gmail.com> <20130821220021.GA32130@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 22 13:27:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCT3U-0001NP-3b
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 13:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042Ab3HVL1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 07:27:51 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:52542 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011Ab3HVL1v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 07:27:51 -0400
Received: by mail-ob0-f182.google.com with SMTP id wo10so3376845obc.27
        for <git@vger.kernel.org>; Thu, 22 Aug 2013 04:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jyqgYhWSuDBLTMFkDScAkDhPTLWwZqJPe466cEqgAwg=;
        b=KlML+fddDyLZEGWyQWi3n6eRRfOlMDvAmd3gvf7gYc4h+JLavxfGTBw20b7H49OC4l
         pYccFiPdlpBYBSzvAlYConoHj1ul0wKoKN6GT1CjRD7ENpEoBOCQdO4KfBd5JvnDNBvb
         zQxo4zC+547b5BkhWjzDKrQtKWwU/Lg3YhfiVF1maBcmSd4e8XiI4gr2LDtyOWokXsIa
         l5J6baWWgfu1q1eptq5R4vd6dZ+D9MFzynwCetF2QdxfdICMoE65hj/BLNbyt9PsQ3ID
         BZEcX9SYxjnOyOcrvtSQVtU2mb+yTmdF1BapQ8W/+KACUFbIUZSbzet4TibXIfp76k1t
         lzqQ==
X-Received: by 10.182.66.229 with SMTP id i5mr1204890obt.88.1377170870316;
 Thu, 22 Aug 2013 04:27:50 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Thu, 22 Aug 2013 04:27:20 -0700 (PDT)
In-Reply-To: <20130821220021.GA32130@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232765>

On Thu, Aug 22, 2013 at 5:00 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Aug 21, 2013 at 08:45:13PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>>  On the topic, C Git's (maybe) violations on this spec are:
>>
>>   - The client does not strip trailing slashes from $GIT_URL before
>>     sending to the server, as described in section "URL Format".
>
> Yeah. We get the basic gist right by not adding an extra "/" if there is
> already a trailing slash (so you do not have http://host/path//info/refs").
> But we do not go out of our way to remove multiple slashes that the user
> hands out (either at the end or in the middle of the URL). I doubt that
> it matters in practice.

It may make writing rewrite/matching patterns in http server a tiny
bit harder, but should not be a big deal. I agree with Junio this
could be something a new contributor can work on to get familiar with
(scary, imo) transport/connect code.

I agree with the rest of your comments that those "violations" do not
matter much (when I raised them I did not mean "fix Git", just
checking if I missed anything) and the document is ok as-is.
-- 
Duy
