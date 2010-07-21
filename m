From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: CRLF behavior
Date: Wed, 21 Jul 2010 17:52:38 -0400
Message-ID: <AANLkTiktnUV8WWSFcsj461QiG6WNv_kKxNFdJ5MBtdoy@mail.gmail.com>
References: <1A9EA7E081C3FE46A0F446FFB66D10EB9398F1@FL01EXMB01.trad.tradestation.com> 
	<AANLkTil5hUWwSXcz9T7cgeU_LwYtx8Nio7lUaUebJ5YM@mail.gmail.com> 
	<1A9EA7E081C3FE46A0F446FFB66D10EB9398FF@FL01EXMB01.trad.tradestation.com> 
	<AANLkTinyTlrkALbfVqdqzr_O4ClN-JGS9zsYwH1Upe1v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 23:53:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObhDt-0002j2-TV
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 23:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758794Ab0GUVxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 17:53:00 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42051 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755019Ab0GUVw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jul 2010 17:52:59 -0400
Received: by wwj40 with SMTP id 40so2843998wwj.1
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 14:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=qIibUisW0RW+i2/EthpC1QGVL+uI/gdasfGOKxlMViQ=;
        b=gMPhe8T1CIRY4HQxfOFyOPfAYUc22Zoegpjne/DS4Jhz0KuuEl9aRu3xhuDB9A5B8X
         Pm0KnpDoCkR2wPXXrMbN6Ni/ZQbgYzxFx0jDNL01IayNtQ2uWWvHEI/wR42VHj1oK+xp
         Em9Z0nNLa5oi+gIM593WLdhSh6KwagSZvIQXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=fPRzvk2qZBXfnTv5DwcyXSkyppKqIhqtsDNq16MILvfWKi/8L2HFqoDk5LbpO/QJo1
         7cv9DsJhC6dShzxGsuBGEpMdTQH5yz7V7ZMZ3mC2P5QGNT/l31JLTaqAJpKHaqgYA4xc
         jEAIv7Ab5nbGvaTfiPsNhVNEEwL2kKnWuKnn8=
Received: by 10.227.134.85 with SMTP id i21mr810755wbt.127.1279749178175; Wed, 
	21 Jul 2010 14:52:58 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Wed, 21 Jul 2010 14:52:38 -0700 (PDT)
In-Reply-To: <AANLkTinyTlrkALbfVqdqzr_O4ClN-JGS9zsYwH1Upe1v@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151424>

On Wed, Jul 21, 2010 at 5:51 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
> On Wed, Jul 21, 2010 at 5:35 PM, John Dlugosz <JDlugosz@tradestation.com> wrote:
>>> > Running git config --list shows nothing that would suggest any such
>>> setting.
>>>
>>> Try 'git config --global --list'
>>
>> I thought that --list tells me the sum result of all the settings in force; i.e. the final result that should be used here and now.
>
> Sadly not.

It take it back: it does do this.  But if $HOME isn't set, apparently
it silently fails to read $HOME/.gitconfig and uses a different set of
options.  Just confirmed this myself, and it's true.  This probably
should be considered a serious bug.

Avery
