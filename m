From: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] git-imap-send: use libcurl for implementation
Date: Sun, 09 Nov 2014 14:00:54 +0100
Message-ID: <545F6586.109@web.de>
References: <53FD0CD1.7030801@raz.or.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bernhard Reiter <ockham@raz.or.at>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 14:01:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnS7D-00052Z-3w
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 14:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbaKINA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 08:00:59 -0500
Received: from mout.web.de ([212.227.15.4]:52203 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873AbaKINA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 08:00:58 -0500
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0LmcRH-1YLxmW4BIR-00aCf9; Sun, 09 Nov 2014 14:00:56
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <53FD0CD1.7030801@raz.or.at>
X-Provags-ID: V03:K0:xS3IIR1FhtWQJWFSbBIUGm2ntKW1HaQKYOavSXcvGLYEVEOrbxi
 UWuDaD1VGkIN3iFpE4Pe5U9C2DUsVpguimaV+9sLlRc34w8vqClQ5Te8hBgbKrQYXiJWZMa
 K4AT8utKAQbjqYAMtU907ziIi7TjfekxIl58oP5cEaIdUg5xcOF5z0GI2YnM02tvYLVzDao
 gygJW/n7k/45laCyryWjg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2014-08-27 00.40, Bernhard Reiter wrote:
> Use libcurl's high-level API functions to implement git-imap-send
> instead of the previous low-level OpenSSL-based functions.
> 
This doesn't seem to fully work under Debian 7:
/home/tb/projects/git/git.pu/imap-send.c:1546: undefined reference to `curl_append_msgs_to_imap'

Some more info:
 curl-config --vernum
071a00

 (echo 072200; curl-config --vernum) 2>/dev/null | sort -r 
072200
071a00

(echo 072200; curl-config --vernum) 2>/dev/null | sort -r  | sed -ne 2p
071a00
