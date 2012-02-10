From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] tag: make list exclude !<pattern>
Date: Fri, 10 Feb 2012 13:34:26 +0700
Message-ID: <CACsJy8DVXCLb50Vd0fTU+yNP2q7Gkcr88muHuzxq1jhfJW5Q9w@mail.gmail.com>
References: <1328816616-18124-1-git-send-email-tmgrennan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 07:35:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvk4V-0000dC-1S
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 07:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758175Ab2BJGe6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 01:34:58 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:32851 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754823Ab2BJGe5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2012 01:34:57 -0500
Received: by wgbdt10 with SMTP id dt10so2456849wgb.1
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 22:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=BT957wS0zFM+A4T17Y0HMLC4vEJtLYcyjpijNFuu8CQ=;
        b=fEVHaIcH6lod9TSzVP8xHhWRGQFU/6sCHT8fik5+yHDJfhhyZuK+yMB5PXvu5u3V+9
         mq+3j551SsXNJSlFNmCo7dSP4TNqu0M8u4FStO0ZBfQb2sgTkf1+onmp/tAfPo5PhhdU
         1VN2P4DswLzt0raMwfCy0gG3maP6FxWlkrkA0=
Received: by 10.180.86.9 with SMTP id l9mr7259085wiz.15.1328855696270; Thu, 09
 Feb 2012 22:34:56 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Thu, 9 Feb 2012 22:34:26 -0800 (PST)
In-Reply-To: <1328816616-18124-1-git-send-email-tmgrennan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190384>

On Fri, Feb 10, 2012 at 2:43 AM, Tom Grennan <tmgrennan@gmail.com> wrot=
e:
> Please see the following patch which filters the tag list of "!" pref=
aced
> patterns. =C2=A0If this is deemed desirable and correct, I'll resubmi=
t with updated
> documentation and unit tests.

git-branch, git-tag and git-for-each-ref are in the same family. I
think it's good to that all three commands share things, like this
pattern matching.

About the '!' for exclusion, maybe it's better to move from fnmatch()
as matching machinery to pathspec. Then when git learns negative
pathspec [1], we have this feature for free.

[1] http://thread.gmane.org/gmane.comp.version-control.git/189645/focus=
=3D190072
--=20
Duy
