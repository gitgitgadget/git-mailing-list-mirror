From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] Handle more file writes correctly in shared
 repos
Date: Mon, 11 Jan 2016 10:28:28 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601111018550.2964@virtualbox>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de> <cover.1452085713.git.johannes.schindelin@gmx.de> <c03e5a9d367b76d8a249680c752b4c4d935e9b91.1452085713.git.johannes.schindelin@gmx.de> <xmqq1t9t3vn8.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1601081704280.2964@virtualbox> <xmqqbn8w2brm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>,
	=?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 10:29:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIYmn-00005j-VT
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 10:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758845AbcAKJ3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 04:29:09 -0500
Received: from mout.gmx.net ([212.227.17.21]:65165 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758242AbcAKJ3G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 04:29:06 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lm2lZ-1ZjDtG2iBt-00ZcwB; Mon, 11 Jan 2016 10:28:31
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqbn8w2brm.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Me5xvfMEBxf2US1Q+6HQkAX8gak9PnObSxVU0DmbF7QoV1UaK3s
 TlxfrhCYerEirLbF1yg4lYlyj9fyqdJbpixVYWkgOgIT2RBdrSRrjDV8OHq1ZbW3Hia0z2s
 naow9JHz5747pxKiQamoTvauwaB3JvbgnkpWvVBPZPj61ot3wcjCy/fbjE1VLx3ZR3sDrQr
 eShmYE3xxF1fdkaoYjwDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X4hx8NIW4aA=:K7CYHdzmhcg0xo/IbXlbq6
 ViE9Y87AazF0Y3c9RYlCFzRZ2nORa6mq3cK3goQy/Jt8sVFhSqqwQh2sitlNCTk3denLezRq0
 D8QvK4wLAJmW/SlqZUcqykarAKgIqvOCx0XbOLLZC3kegtINJ2PlgGY9UWpoNtkFT/3YLRw8R
 vH+WQNmeDBf+vO8YxZQtlQJxOn8JiUUerrVcZevDx1TZI7p3f8LjnIRuQP/LdIyuOgGzZ+1i6
 kX/qiguntWrBcu+WFDS7pN4QC66cV0zGNOyoLdCnZS5JRDh5CEMaZ58Ij2XsveZarXIYWTfci
 Vu/cPSmvnWWA+dm3xfZIv3OiEvH/sUGCqGz2/utOeGZahN7CHxeVJpXtBIgUlV7WrNvc8lkd5
 J0aM0FwIavvKDkp+I3INn8tvnPNXtnhEXpNfFjiatAyoboim8LMqTpFwsTdHy/6ConcaEhgdS
 0o9qv4gdTzkz1yf9pKNFCJ8E5xLt3fUoq5OQaLWhuKUrJAOh84w5aJFz37np7ri8ZFVHi/veD
 Hq6FA3Y34d1OtqEDpYEOvVJGLuULVZCigXHLb1wbjC05ckJ0Y6bxnodPCQlygMtYpsohUUyRY
 p+6+73w/8XnIXCS4Agz6JKfmporGO5gNCfoOx2AtJv1ex/RvLHSTYJttZdY/DFP4Kah847GdY
 UMHsjDyGvYbxymP+JMheE5BTkkoUQn5Gy35SGkhsg5XXqdZeAy+z4VgNxb46/wIpGtPCPMJr+
 pRumSqMXVNGmBfSnaVsyqWk44R8MWghhbVEQTGJDbTK2MIZNcS4klyPfasleBhMD2UPE1x+a 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283641>

Hi Junio,

On Fri, 8 Jan 2016, Junio C Hamano wrote:

> I think it is correct not to touch this codepath in this patch,
> because of the above two reasons, but more simply and generally, it
> is correct not to touch this codepath because core.sharedRepository
> is not about working tree files, and .rej is a file you use in your
> working tree.

I am happy to adjust the log message, but I am pretty certain that the
`core.sharedRepository` setting actually also affects the working tree. At
least in my hands, calling

	git clone -c core.sharedRepository=group . test-shared

results in all of the working tree files being group-writable.

Therefore I am not convinced this is a sound line of reasoning.

Ciao,
Dscho
