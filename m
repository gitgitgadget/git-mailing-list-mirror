From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: git tag's history
Date: Mon, 26 Jul 2010 16:17:55 +0200
Message-ID: <20100726141755.GA13721@vidovic>
References: <AANLkTinCTcnr=tyC2+C4u5L0p_mXxTCMfSBm_JzqqMDW@mail.gmail.com>
 <AANLkTikTqJVbohquiNmW0BvP0bXsVFyMw0H4qF2FbhiH@mail.gmail.com>
 <1280151367.8229.28.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Mahesh Vaidya <forvaidya@gmail.com>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 16:18:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdOVK-0002pi-Pv
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 16:18:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548Ab0GZOSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 10:18:00 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33137 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265Ab0GZOR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 10:17:59 -0400
Received: by wwj40 with SMTP id 40so199904wwj.1
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 07:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=PGg1s1D7o2sKEoWk3jxRy6Ym9QHV7p/lAgdteQXfd+s=;
        b=HMlKehaS5Z9SdIa7D35rNyr0KLm/K2D/TLQaLv+PwIECFyiz44DawO6Juqhn3VHXto
         MIwcqYYzgUWMBv2kUL5yhzQoSS44TlNyO3zxK9ADuX92vn89eRTcbukubznK4Pa2k81r
         lKyt8a5HOJQRnwFtNe0frks2ZCM84GRaaf7cc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Jn+7B1nvx0c7T2MASX0IMz97mwGBioIOmKwE4yDEiHq0U5ZZ7FOt5IqhlD4CbaT7le
         NMjZ1cxAH8ng/me1UTI9vQ5rw7T2zV+mfrWonPZC9rkDncuRS2s1krwzRk/rtBcPzeTX
         A0GwIwZM/dzGPlVttSyUstn72F01K/uDqyFHM=
Received: by 10.227.153.208 with SMTP id l16mr7493372wbw.57.1280153878127;
        Mon, 26 Jul 2010 07:17:58 -0700 (PDT)
Received: from vidovic (aqu33-8-83-155-187-36.fbx.proxad.net [83.155.187.36])
        by mx.google.com with ESMTPS id g37sm3171211wbg.3.2010.07.26.07.17.56
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 07:17:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280151367.8229.28.camel@wpalmer.simply-domain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151840>

The 26/07/10, Will Palmer wrote:
> On Mon, 2010-07-26 at 02:36 -0700, David Aguilar wrote:
> > He won't be able to push the tag unless he forcibly deletes your tag first.
> > 
> > Tags do not have history.  This is a non-technical problem.  If s/he's
> > deleting your tags, it's a social problem.

True in the first place but I see nothing wrong to want to have
technical safeguards around social issues.

> What about enabling the reflog on the shared bare repository?
> Tags get changed. That's a fact. It's a necessity, no matter what the
> theoretical model says. Sometimes there's a reason to replace a tag, and
> when that happens there is sometimes a reason to hang on to the old
> value.

Sharing a central repository makes it exposed on such erasure. Git
provides other mechanisms to take more control. Your workflow may not be
what everybody want for themselves. You should look at the hooks system,
I think.

You might also be interested by gitolite, an external tool (I'm not sure
it could help on this particular issue, though).

>        Pretending "it's a social issue" ignores reality, not the least
> important aspect of which is "social issues happen. How do we avoid
> losing information in a sane, scalable manner?"

It shouldn't be lost. The bare repository can be seen as a gate to
publicize local work (or a backup copy sometimes). The original tag can
be restored by his creator from his local repository.

> Just an example of a tag which could stand to be updated, take a look
> at: refs/tags/junio-gpg-pub  There's at least one thing in there which
> is out of date.

Hard tags are designed to be immutable whatever happens after the
facts. This is why they exist.

Public tags shouldn't change as it would break other up-to-date
repositories.

-- 
Nicolas Sebrecht
