From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH] Makefile: default to -lcurl when no CURL_CONFIG or CURLDIR
Date: Mon, 28 Apr 2014 13:52:27 -0700
Message-ID: <CAD0k6qSxBq+VAZ2CH-vR-Pyk4FjKKeJmngBU5T9Z-cwSH1LffQ@mail.gmail.com>
References: <1398714653-1050-1-git-send-email-dborowitz@google.com>
 <20140428200550.GO9218@google.com> <CAD0k6qR766hrgUtyiGzZ9KM5woknfsyUm3Mf1-Pm3M-LrL2Zhg@mail.gmail.com>
 <20140428205058.GQ9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 22:52:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WesXm-0005Js-Bt
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 22:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750AbaD1Uwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 16:52:49 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:62303 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062AbaD1Uws (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 16:52:48 -0400
Received: by mail-la0-f54.google.com with SMTP id e16so5281773lan.27
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 13:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gBfzvH3DTOOnDQf03FbmFnkjEhpzV4hx/azJsjYq43k=;
        b=dyZ/EzpXYv+14fcdj2EbOTxfKnkmAajAVdpnAIVRuH5PXEL50hSb618/jjYewKDk3R
         29kcL+TSHWL7e4+SIskNftxbGFGlc/jKLcHhu2WLuT/9Y1+j/8PvFKY7uoeeLCQemGUA
         BK/tGm1c/yoXKm0SlZk4ntSCMXEqvlg8E130tEjMDEe+WcCziItS+dDxokDM4Bq5jvHK
         tPoK3bxR7IYwvEb0MklAYWNH9Lh7mQeSnRfMeHO8mseAwBstjs0oNbHTXC3EylxW3Gke
         6o5YqobwV3DRjJtIvyq+F/qFvx8SCHaJt3A54zf+cQK6miIJP0xEDCAJCIICm/5NxVdH
         XVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=gBfzvH3DTOOnDQf03FbmFnkjEhpzV4hx/azJsjYq43k=;
        b=TyIKPE9P6o3DnAgSOv0NWJBWb1OBYgOv6JTjuwmGgrMKQs4f+ys6ufUBxDTQMSnaGO
         ms30V1CwxRBMczGsKg7+at8T9u1WCw3MhSXYdrqILgi7kNZQsv1va7/wtvQJ62BOYR0q
         mGbU19oL0V1+h4DMKOk++KeT38yR4iTfEoVI4qdJZ3rynFeJN+vJ6DcyOEDb/mHJbXk5
         zY0l5jQiP1LBsF4/26AOUmT/fs5+Tl3/pbzz52zmLqZXspsnRUUPwOreQ/RfnzJgoGNS
         e1ROum6zT0oJWBf6qkdqveCoZSF+LWRHZuH5IB3/q/UWT2DOPX0UnIBryl1bhHNrjhBx
         lBGA==
X-Gm-Message-State: ALoCoQk0ltNLdli2apSyntJ+2m1BI/jBBffkCQbzUDuTttKTnuszD5abDsqn6dRvsgtf3Qiuy/oxq7MkgDDkvKzhqZ70VbXysNPlTnuemxJWr5nJ1YdsJZL85WVbEPSLGersoaMCmchDXJc/cXtJNTMM5WkW1trSudT5k84J8cYPPdEa96zHEPJJvY7QQ330MkB8qOa6F+rF
X-Received: by 10.152.42.144 with SMTP id o16mr20899856lal.9.1398718367599;
 Mon, 28 Apr 2014 13:52:47 -0700 (PDT)
Received: by 10.112.184.227 with HTTP; Mon, 28 Apr 2014 13:52:27 -0700 (PDT)
In-Reply-To: <20140428205058.GQ9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247448>

On Mon, Apr 28, 2014 at 1:50 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> $ echo -e 'ifndef FOO\n\t$(error bad things)\nendif\n\nfoo:\n\ttouch
>> foo' > mk1 && make -f mk1 foo
>> mk1:2: *** commands commence before first target.  Stop.
>> $ echo -e 'ifndef FOO\n  $(error bad things)\nendif\n\nfoo:\n\ttouch
>> foo' > mk2 && make -f mk2 foo
>> mk2:2: *** bad things.  Stop.
>
> Gah.  Maybe it should be left-justified to avoid accentally breaking
> it again.

I am ok with that on the basis that it is better to be ugly but
obvious. I suspect if the Makefile were more littered with conditional
$(error)s we would reconsider using tabs as indentation.

> Thanks.
> Jonathan
