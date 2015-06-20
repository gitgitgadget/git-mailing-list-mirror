From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] upload-pack: Fail if cloning empty namespace
Date: Sat, 20 Jun 2015 11:06:50 -0700
Message-ID: <xmqqr3p6jltx.fsf@gitster.dls.corp.google.com>
References: <1434140115-3139-1-git-send-email-johannes@kyriasis.com>
	<1434147436-21272-1-git-send-email-johannes@kyriasis.com>
	<20150612223223.GA22677@leeloo.kyriasis.com>
	<xmqqh9q87l3x.fsf@gitster.dls.corp.google.com>
	<20150620142705.GA23163@leeloo.kyriasis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes =?utf-8?Q?L=C3=B6thberg?= <johannes@kyriasis.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 20:06:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6NAQ-0000CS-Jr
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jun 2015 20:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755325AbbFTSGy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Jun 2015 14:06:54 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:38508 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754121AbbFTSGx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2015 14:06:53 -0400
Received: by igblz2 with SMTP id lz2so31624847igb.1
        for <git@vger.kernel.org>; Sat, 20 Jun 2015 11:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=fMoK6JjafYkSeLcjbfZKcdKX+lfE3MQkryezDRKDSVw=;
        b=JhHUGRw/ohi6uNbHV3CIkONE7/z3GVBWWb4ooNJkNq82tlAqtM5Z9+OHalE9Ba/0jA
         giEJKxlnx41sCQ1iw7bv70JucZpfCozo7YQvTiXSoAd49Vv5cLYH0utcIULXTC6npUXP
         Ig9pKGK/kG8yXXdmBPcGqpwVBUPu/GpmJLhwrK4JphQjjU1FcyqWE6i0qz+vvbqhwsE+
         Wd9VYwf7Q4//Xj0rBvuPpqVUJ8yvx7MX3mBjcj6/9BRFWuUvixZU4+oT2HrSqo8TFmy7
         Gx1nnsFfa9+LXv7JmHXgg9o+6S+ubYEU/eZL/wkFe/IIzarhI049naR5sHUjRqIKSRdC
         lsTA==
X-Received: by 10.107.14.65 with SMTP id 62mr18056547ioo.67.1434823612491;
        Sat, 20 Jun 2015 11:06:52 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f44b:8ca4:e732:8441])
        by mx.google.com with ESMTPSA id pg7sm4142584igb.6.2015.06.20.11.06.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 20 Jun 2015 11:06:51 -0700 (PDT)
In-Reply-To: <20150620142705.GA23163@leeloo.kyriasis.com> ("Johannes
	=?utf-8?Q?L=C3=B6thberg=22's?= message of "Sat, 20 Jun 2015 16:27:45
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272237>

Johannes L=C3=B6thberg <johannes@kyriasis.com> writes:

> On 15/06, Junio C Hamano wrote:
>>You would probably want new tests, but more importantly did you make
>>sure this passes existing tests?  It seems to break 5509 (there
>>could be others) at least for me.
>>
>
> It breaks 5509 currently yeah, though I've already fixed it locally.
>
> Anyway,
>
> You create a namespace by pushing to it,...

You keep repeating that, but I do not think we agreed that it is the
supported or correct procedure to set up a new namespace in the
first place.  Doesn't the server side need a lot more than just
setting up HEAD symref (like running upload/receive-pack with the
path to the hierarchy exported as GIT_NAMESPACE environment)?
