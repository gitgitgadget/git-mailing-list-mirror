From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Commit cache to speed up rev-list and merge
Date: Fri, 28 Sep 2012 08:43:26 +0700
Message-ID: <CACsJy8AodZgikh0Fq3=asUx94bx1_mdNNHzuuprNm8czXkbKxA@mail.gmail.com>
References: <CAJo=hJtoqYEL5YiKawCt_SsSUqfCeYEQzY8Ntyb91cNfNS1w_Q@mail.gmail.com>
 <20120927173932.GE1547@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>,
	Colby Ranger <cranger@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 28 03:44:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THPcg-0001vo-2y
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 03:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756362Ab2I1BoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 21:44:00 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57960 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756315Ab2I1Bn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 21:43:57 -0400
Received: by ieak13 with SMTP id k13so6159482iea.19
        for <git@vger.kernel.org>; Thu, 27 Sep 2012 18:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GcgRjBxMTviOBT/1xd24gxAvUpUXa595i9gOk3xd7PQ=;
        b=PPQFEren0b86LQYv62fL7Gw9BIkiKQ3LPAvX6xWksEaKgt85Rq6hsa8LlrpZ/sFBKN
         aCszfpK98Q+HC/ACfuQXCzB5oEXybquF5srmy7UcQlarA1tlDx6tyXqJFiJ6j1YC0zlF
         QQ9doOpiXYkBlvqzjpTu2PNEhgl2YUtm+XZbO5BW49OucwRgiDvRJzOAjKrs0srEMxeQ
         C7paby7uUYLamN8Pml02czsdEcGZqnBNiKnMLmfb/6cvz8E3s/FDgUe3902HQVRX8c8p
         GZqYgblWpME3mFAJEcCS3RDy0+WWu47m3CZ96REcSuCFDCpMNpA7TqTgLW9MsRYwPdqT
         kyhA==
Received: by 10.42.62.143 with SMTP id y15mr4412366ich.38.1348796637128; Thu,
 27 Sep 2012 18:43:57 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Thu, 27 Sep 2012 18:43:26 -0700 (PDT)
In-Reply-To: <20120927173932.GE1547@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206534>

On Fri, Sep 28, 2012 at 12:39 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Sep 27, 2012 at 08:51:51AM -0700, Shawn O. Pearce wrote:
>
>> On Thu, Sep 27, 2012 at 5:17 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> > I'd like to see some sort of extension mechanism like in
>> > $GIT_DIR/index, so that we don't have to increase pack index version
>> > often. What I have in mind is optional commit cache to speed up
>> > rev-list and merge, which could be stored in pack index too.
>>
>> Can you share some of your ideas?
>
> Some of it is here:
>
>   http://article.gmane.org/gmane.comp.version-control.git/203308

And an experiment was done earlier

http://thread.gmane.org/gmane.comp.version-control.git/194306/focus=194596
-- 
Duy
