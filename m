From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [cgit PATCH] use Host: header to generate cgit_hosturl
Date: Tue, 2 Sep 2008 01:14:31 +0200
Message-ID: <8c5c35580809011614k6ec5a0e9tdfd5d3031c58b84@mail.gmail.com>
References: <20080901063033.GA21848@untitled>
	 <8c5c35580809011336v58b139acu5078cafd3440c786@mail.gmail.com>
	 <20080901230741.GA19984@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Sep 02 01:15:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaIce-0001G9-Kf
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 01:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbYIAXOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 19:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbYIAXOc
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 19:14:32 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:49532 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbYIAXOb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 19:14:31 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1474001waf.23
        for <git@vger.kernel.org>; Mon, 01 Sep 2008 16:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Jkg2CLemx0O0PwI7a5WBppc7lwyIc77atbC2/UYdNRA=;
        b=mRe0dmapm20u2Kn8bsZ2zALxdRBRB/QQog/bWHKazK1JfeBszIrEeyJKUbc/Ldxdvq
         AtK2pliOPYnK7Edcsko8ApdFiRiBLTzchzPEBbDZ5IeICZoWN5devrqzdpRCeunEZ6lM
         yMsRia+Q1tCIJqtr/i9+6+/fL/RK7cUL9c9FE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=pUyOub3jvrHl1oFt5JxsZbjDsfSh9pb+GEMQAMKQ+P75QwvBQp1Qb+V1YW3Jbwo5fS
         X+hWmrDyVPlGKGBZnxKp4cuwwNxrcu5eRf9c09dV5RHOloPXxG/uqTLvQk0sbV9LECqb
         SXUd+fG7yhiVtVq+ZF6td3s215f7cXGypZQ8U=
Received: by 10.115.16.14 with SMTP id t14mr5724723wai.55.1220310871132;
        Mon, 01 Sep 2008 16:14:31 -0700 (PDT)
Received: by 10.114.166.20 with HTTP; Mon, 1 Sep 2008 16:14:31 -0700 (PDT)
In-Reply-To: <20080901230741.GA19984@hand.yhbt.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94627>

On Tue, Sep 2, 2008 at 1:07 AM, Eric Wong <normalperson@yhbt.net> wrote:
> Lars Hjemli <hjemli@gmail.com> wrote:
>> On Mon, Sep 1, 2008 at 8:30 AM, Eric Wong <normalperson@yhbt.net> wrote:
>> > So use the "Host" header if it is available and fall back to
>> > SERVER_NAME/SERVER_PORT for some clients that don't set
>> > HTTP_HOST.
>>
>> Maybe it would be better to use a new cgitrc parameter as fallback if
>> the client doesn't provide the "Host" header?
>
> That sounds a bit hackish to me since HTTP_HOST, SERVER_NAME and
> SERVER_PORT are all standardized.  Anyhow, it's your call :)

I just figured that since SERVER_NAME/SERVER_PORT doesn't work in a
setup like the one you described, clients which doesn't provide the
"Host" header would never get a correct url. A default value for the
"Host" header in cgitrc would work around this issue.

--
larsh
