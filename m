From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v7] git-p4: improve path encoding verbose output
Date: Tue, 15 Sep 2015 08:36:17 +0100
Message-ID: <55F7CA71.1020203@diamand.org>
References: <1442250640-93838-1-git-send-email-larsxschneider@gmail.com> <1442250640-93838-2-git-send-email-larsxschneider@gmail.com> <55F7C93D.1080309@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 09:36:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbkmt-0000So-1r
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 09:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbbIOHgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 03:36:19 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38638 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbbIOHgS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 03:36:18 -0400
Received: by wiclk2 with SMTP id lk2so14427234wic.1
        for <git@vger.kernel.org>; Tue, 15 Sep 2015 00:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=p6wGT5/Rs3AZmhtiVuB553zqJ3NQWgkhHYFQ+JErgUQ=;
        b=DT1/+6mHEg3gPN1qFDRK+/JhENCMGon6Sc8F1a89tHgXxj9SmKY0E1A3Kgqmi/XbKn
         swrZtVTT9SzK5Gml1fdd4ha/mGZQFT4z1UfnfHV+up6jLW02e7WorzgcN1VwXQohz3Qy
         aC+CvMmNn+H2zPpEhK7XXXD/bppv58LSPYxGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=p6wGT5/Rs3AZmhtiVuB553zqJ3NQWgkhHYFQ+JErgUQ=;
        b=KhWEfg+s8kJh87aBHZHewbMIFTu/WoZ6Do7ygFVvd5g8dc7nm4auc4SPl9b5XrK3L2
         iTUcXUrCbti05BqXa7aQRc76k0t96XviIDvh+nVgMv7GjlQ/uQB1kNV11q1FA/iRsc15
         7oRVO0GL8HFSdkeX2G3ZTlk2vKmMVyE2AVRic8AWshaeh1mMxxJq4cVI2F2GykrzIW8r
         EMvELuLXLjniG7HBta32C8G281+9tyalEphA8SHHm/t4lBk9xLAmLJOq+S5HuYl9xCPN
         Z+oYDQ3nlaPXRk4SPPB0QampaaFjuNfa+qFOj0AvN2e/cKJBPSgncKZ8uawdFVZo9EQb
         P48w==
X-Gm-Message-State: ALoCoQlnGzHbVdBVshDrGSpCuds5gzWUjMKzE6fiP4gBDkUqrzOCWkADYpTS2Ib+E0J62aH47pWM
X-Received: by 10.180.8.164 with SMTP id s4mr4516301wia.5.1442302577220;
        Tue, 15 Sep 2015 00:36:17 -0700 (PDT)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id qq4sm19515227wjc.14.2015.09.15.00.36.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2015 00:36:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <55F7C93D.1080309@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277893>

On 15/09/15 08:31, Luke Diamand wrote:
> On 14/09/15 18:10, larsxschneider@gmail.com wrote:
>
> It would be better to query this once at startup. Otherwise we're
> potentially forking "git config" twice per file which on a large repo
> could become significant. Make it an instance variable perhaps?

This is of course complete nonsense since gitConfig caches its results!
