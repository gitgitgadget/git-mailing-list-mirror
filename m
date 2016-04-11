From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 3/3] index-helper: take extra care with readlink
Date: Mon, 11 Apr 2016 06:17:24 +0200
Message-ID: <570B2554.1010105@web.de>
References: <570ADBCB.4040503@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	David Turner <dturner@twopensource.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 06:18:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apTIa-0004DG-W5
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 06:18:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbcDKESA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 00:18:00 -0400
Received: from mout.web.de ([212.227.17.12]:57612 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750718AbcDKER7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 00:17:59 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0McWnE-1b78fN2hF2-00HgNu; Mon, 11 Apr 2016 06:17:33
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.6.0
In-Reply-To: <570ADBCB.4040503@ramsayjones.plus.com>
X-Provags-ID: V03:K0:H2W10xNnze9duDSFTHEPntzFkBT4+gXf+a8ECuv1EvpDTEw2thw
 zVKAXTvDYSDIjXeT++nCDRau1xvWTvuIS9npimaFkYb/55ZiDnxUoDa60N09XwFfam1xqBk
 H/5yeRbgq0BNK7IzKHygw66ONppA6Z5JXPsBwHx869uX+rxu46Sn1370O2Mmc0QMgu7mdtn
 2sxhtrAulc224qW7OmenA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cvdVrDG54uw=:qfdzrgP7lh/uyiL+x7GK2N
 eTXLgkkMuZp4+OMlKFV5t0HPqTDH9WXc0jf1x9EycDZ4QZGFQtoXYCExvQ1azwNutKIQR6Taf
 MrDHWp3W6CuorgK8f8yc83sUkiKHg/olWYpDqxq4O0ZDOLH9ouq0OVjQXjkxn8Yojd/NVMIaM
 UGrkWVPDm3/ED4h5GAi7WoekQvV7dj9YqInOK7B1e3knP8ZQkMh9Ss2qa6bigtpFdkt31z2Bv
 vVCXoL3Uqwwh8pybSxEpuV1ksx2Na0MG8kpEgU/EFPBun6lNsV0LwSMilrvz4l/stcuIE3KK9
 g/aMNvJQ+GacqttwzObqhLBsCGY+/WdFQNzQ94v5Z/yBLZOuYTjD2vU6RSVUi9J3ex7+JV85s
 fizXpOLGuN1EUfENFWTagqMGqlJBmmJQxNZ/3vDbn37t98S8hkI2neELK/BFSPA8YCvUXiANx
 S6Y0c828czcmbQaKiRwGuaoI+jhcz/Xlqp1Zp2AeF1/EdRbtYrJ+/kC0kfYWv1yyy4SoEpJya
 XYQQzO9Tk6RUupxghcqh+aLuISg8Gi9KA+361kYdNBF9dk9YUU8wWlN2rOUkJkGrmnJv+M/cj
 t4yuiTyTQ0cT7R5ipkhaBesF6U3sHIA7T08ZYfwZKcdbW271O6i25wP4V/J76NS63QOoggx6h
 xAj+Hxo7Mq4YqyuC8FTaL8xVAifxIP1BUfEQOLmcsU2aJKxhyAQMUY+F0FwsM8IB5T74KnLKJ
 YBmPXAhwYELDRS+QRVPlpMAVkqfRhIvY7nk/w2t3eBiu+Q/K20LUKPXZedsVIop2123ueLXc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291203>

On 04/11/2016 01:03 AM, Ramsay Jones wrote:
> It took me a few minutes to convince myself that, if index-helper is
> the only writer for the symlink, that the call to readlink would
> result in a properly NULL terminated string. This relies on the
>
Minor nit:
s/NULL/NUL/
