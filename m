From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 04/12] ref-filter: implement an `align` atom
Date: Tue, 25 Aug 2015 10:56:20 -0700
Message-ID: <xmqqlhczz1yz.fsf@gitster.dls.corp.google.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
	<1440214788-1309-5-git-send-email-Karthik.188@gmail.com>
	<xmqqmvxg2v3u.fsf@gitster.dls.corp.google.com>
	<vpqk2sj7tlb.fsf@anie.imag.fr>
	<CAOLa=ZS1EiU3FFLwR3QUUebCtVkrwUS=qP9xvc93LHanA5eh=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 19:56:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUISQ-0005eb-Si
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 19:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755931AbbHYR4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 13:56:23 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35055 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755922AbbHYR4W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 13:56:22 -0400
Received: by pacdd16 with SMTP id dd16so131059246pac.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 10:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=/+ENqcDeTkb39yHoWQI6VjdEEO3IW7BU1JSTy6G+WaA=;
        b=MNI4OQ/MI6hPWG52NghM1vtLvGoFpacn8xlLD3bqn38dD4J5Kl9TYOmhRegitZyeHb
         tl0PMVmqnBTMpX2w1NbRjI0cZgzRgwyy50MAOnM9STY4BL07V3NCp5XVDPvJTf/TzbK2
         QqBzCK2k8mxo7wNuBGPWh6OFJMI2S+9pAno1Bfd+g1iUeKrQMR7q9PBW9DKZtyo9cKhK
         SHoVh5U5OuWxPS1Ys3hHs48DI3Cb91z9HJE8l0W5ddYK8DOiAW36gHJ5/p/aAlXh+Wco
         QUBFtmuL8+fUHlQ4+bWtXcpviyX1oahv73QoZls1ajMWXJDedY65LvPS5WG9EvXrEtQo
         ztLg==
X-Received: by 10.68.200.40 with SMTP id jp8mr60124705pbc.16.1440525381916;
        Tue, 25 Aug 2015 10:56:21 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:cdc0:fd6d:4069:6223])
        by smtp.gmail.com with ESMTPSA id i7sm21783379pdo.84.2015.08.25.10.56.21
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 25 Aug 2015 10:56:21 -0700 (PDT)
In-Reply-To: <CAOLa=ZS1EiU3FFLwR3QUUebCtVkrwUS=qP9xvc93LHanA5eh=A@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 25 Aug 2015 19:00:13 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276554>

Karthik Nayak <karthik.188@gmail.com> writes:

> I like the idea of using atomv->handler() a lot, mostly cause this
> would eventually
> help us clean up populate_atom() which currently seems like a huge dump of code.

I think you already said that last time we had this discussion ;-)

http://thread.gmane.org/gmane.comp.version-control.git/275537/focus=275778
