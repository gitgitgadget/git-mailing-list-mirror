From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] http-push: fix missing "#ifdef USE_CURL_MULTI" around  "is_running_queue"
Date: Tue, 12 May 2009 06:25:07 +0200
Message-ID: <200905120625.07383.chriscool@tuxfamily.org>
References: <20090510164431.3526.47427.chriscool@tuxfamily.org> <be6fef0d0905110525p7e7072d3y18f5c99b782c9bf9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 06:32:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3jfP-0004Y0-1x
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 06:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbZELE0y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 May 2009 00:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbZELE0y
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 00:26:54 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:48614 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062AbZELE0y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 May 2009 00:26:54 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1E15781804B;
	Tue, 12 May 2009 06:26:44 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1DB6B818050;
	Tue, 12 May 2009 06:26:42 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <be6fef0d0905110525p7e7072d3y18f5c99b782c9bf9@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118868>

Hi,

Le lundi 11 mai 2009, Tay Ray Chuan a =E9crit :
> Hi,
>
> On Mon, May 11, 2009 at 12:44 AM, Christian Couder
>
> <chriscool@tuxfamily.org> wrote:
> > As it is breaking the build when USE_CURL_MULTI is not defined.
>
> thanks for catching this. By the way, how did you catch this? Are you
> building without USE_CURL_MULTI defined?

My main development box still runs an old Kubuntu Feisty (7.04). It
has some libcurl3 packages version 7.15.5-1ubuntu2.

In "/usr/include/curl/curlver.h", I have:

#define LIBCURL_VERSION_NUM 0x070f05

and in "http.h" there is:

#if LIBCURL_VERSION_NUM >=3D 0x071000
#define USE_CURL_MULTI
#define DEFAULT_MAX_REQUESTS 5
#endif

so yes, I think USE_CURL_MULTI is not defined on my box and that's why
the build failed on it.

Regards,
Christian.
