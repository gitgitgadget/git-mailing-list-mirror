From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/5] submodule-config: keep labels around
Date: Mon, 25 Jan 2016 10:06:31 -0800
Message-ID: <CAGZ79kZAt1wfqrf1Hk2p5tx=m9OXednsyRFYP6VeVcG69Do91g@mail.gmail.com>
References: <1453509103-16470-1-git-send-email-sbeller@google.com>
	<1453509103-16470-4-git-send-email-sbeller@google.com>
	<CAHGBnuMM5KWMUZd_ZNkEvP_homqy4kg3z356V3fhsLveZhjtBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 19:06:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNlXC-0005bu-5i
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 19:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbcAYSGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 13:06:34 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:33473 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757894AbcAYSGc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 13:06:32 -0500
Received: by mail-io0-f173.google.com with SMTP id q21so160403437iod.0
        for <git@vger.kernel.org>; Mon, 25 Jan 2016 10:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2pJmiix7G2GzE7om/mM7NQELN2MdlrPFbvMcZkc+HpQ=;
        b=cJD/NeZev2RnCTvA/A7IL03VBctHJF4a7tl2ZOiaep3Qkqhx20yPeFlc5z4XaG1f1d
         T6A94ZY8aiIcXf3iUWN+PqpTYqqdzgFjrA6xR2E2zhDc37PTWcHC9KWgMTFAsHocaE/C
         zkBVV5qkVvbWEbT+SC5GPJcDxINPZ/dABZR7mSa3bxfgEQNuQZBz85cwhHaoH0ieviVK
         jkywI4ihO2I3TjeBJlu6crSUI0++I4L9c2wYt34MeoJpJAHJzdU+vBDLWKgjcpM2z5H2
         s6ObyzHfbvDkZJenhLGKp/deBYjMHiylxMeDax6Lj3HK/3FN7lEx8iyPTKJTcPjri0Mr
         ttuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2pJmiix7G2GzE7om/mM7NQELN2MdlrPFbvMcZkc+HpQ=;
        b=JPv1h07N4OiUI1i8eMWoAsSS6dKU8E3s9JJzXvOnbtuk79fFtK4RAhu1vP4r/ejIQi
         ufUH3kqpkvZo5FNoDykH1IKkYOnr5uM5LkvR7SPC9FAfjq6ZoPZM7QvMKB87vr3/dbVU
         rvG43kJWZ2U4K+/D+gVphHrtdCPgtOWCiR+ua8CKDGSUEd7uiTB2OMh+z5xCH/FotE4f
         Q2vfSC0ikZRR5zRjcBMdizxj+RAKP4klaKxJC1e43jv07VvbpXi+dopNqO2PDrDdRv9w
         3YMzr/XrIPmqfEL7rXXgSHWNY9qs0SHrSvNRg2UgdVdeZ5iFlhkls7T8b4BsArvjxxg9
         I16Q==
X-Gm-Message-State: AG10YOQphjpARhNd5Y6Tb4VqhG4vyZiABjoCuMYtSqg61pyaC6grO4GGFUo48IhtMsXd9IBHfFOgMSpW25g9kaVD
X-Received: by 10.107.137.68 with SMTP id l65mr21372810iod.110.1453745191298;
 Mon, 25 Jan 2016 10:06:31 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Mon, 25 Jan 2016 10:06:31 -0800 (PST)
In-Reply-To: <CAHGBnuMM5KWMUZd_ZNkEvP_homqy4kg3z356V3fhsLveZhjtBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284743>

On Sun, Jan 24, 2016 at 10:06 AM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> On Sat, Jan 23, 2016 at 1:31 AM, Stefan Beller <sbeller@google.com> wrote:
>
>> We need the submodule groups in a later patch.
>
> The commit message should now say "labels", too, I guess.

Sure, thanks for catching!

>
> --
> Sebastian Schuberth
