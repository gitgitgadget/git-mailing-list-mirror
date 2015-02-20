From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Git Scaling: What factors most affect Git performance for a large
 repo?
Date: Fri, 20 Feb 2015 23:02:57 +0100
Message-ID: <54E7AF11.6000600@gmail.com>
References: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com> <CACBZZX6A+35wGBYAYj7E9d4XwLby21TLbTh-zRX+fkSt_e2zeg@mail.gmail.com> <CACsJy8DkS65axQNY70FrfqR5s-49oOn8j7SAE9BTiRVNrm+ohQ@mail.gmail.com> <CACBZZX4T38j9YU3eiHTfkDoZKsgyJFrnJQNm5WBmb9RDenDOBg@mail.gmail.com> <CACBZZX45eCo6YS4EpHvMQjN32+-w5BztfoLiwh_rJTs7FydgoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Morton <stephen.c.morton@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 23:03:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOvfN-0002up-Af
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 23:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000AbbBTWDR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Feb 2015 17:03:17 -0500
Received: from mail-wi0-f173.google.com ([209.85.212.173]:50137 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754985AbbBTWDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 17:03:16 -0500
Received: by mail-wi0-f173.google.com with SMTP id bs8so5894838wib.0
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 14:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=vWebNyvjvNJfSJaEsCnqsKomt9VAyN5uMlkV9bS9T6A=;
        b=mh93h0s28gpjZCCXA8XotWCGkDrRS0gdJkmjlpm/PhXcVKlSvZWoUY8tbTogQZ2pyk
         dNSnNwUhjrE2oVun9ANuS2mLwa7SR5XBUl1MQbdORTaxMzhES1qyX4p05vRS/4vG8fEl
         fwdr+5docV9xQKiVZTDjP6DRepf7MFo7CPTKMQJY8y5UEr3EeCEN/dBBXoa41j0e7yeY
         hSWropJHzK0LOlO9ahlcDRzIpZpJHlhV40e1TDjJB4nCKWbnmuXPqFr7SGTruxLM9SAD
         r9+LYCNVtwEUVqROD/mpHtA49kzq9D/+UQLcpyRR798R+Cawj0Dgpu66ZWOFIKFdXQpY
         uAqg==
X-Received: by 10.180.219.66 with SMTP id pm2mr115015wic.91.1424469795661;
        Fri, 20 Feb 2015 14:03:15 -0800 (PST)
Received: from [192.168.188.20] (p5B156C57.dip0.t-ipconnect.de. [91.21.108.87])
        by mx.google.com with ESMTPSA id er13sm43894618wjc.11.2015.02.20.14.03.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Feb 2015 14:03:14 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CACBZZX45eCo6YS4EpHvMQjN32+-w5BztfoLiwh_rJTs7FydgoQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264188>

On 20.02.2015 15:25, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> tl;dr: After some more testing it turns out the performance issues we
> have are almost entirely due to the number of refs. Some of these I

Interesting. We currently have similar performance issues when pushing=20
to a Git repo hosted on Gerrit. The only difference of our repo compare=
d=20
to others on the same server that do not have any performance issues is=
=20
the large number of refs (about 40k) in refs/changes.

I still wonder why that would slow down a push as we have not configure=
d=20
our clients to fetch / push refs/changes.

--=20
Sebastian Schuberth
