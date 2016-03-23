From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] Make t1300-repo-config resilient to being run via
 'sh -x'
Date: Wed, 23 Mar 2016 09:22:32 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603230921160.4690@virtualbox>
References: <cover.1458668543.git.johannes.schindelin@gmx.de> <b4df45088aa68d8410895f66a814dd6780e2e451.1458668543.git.johannes.schindelin@gmx.de> <xmqq7fguie7t.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 09:22:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aie49-0005IP-A3
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 09:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865AbcCWIWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 04:22:53 -0400
Received: from mout.gmx.net ([212.227.17.21]:50186 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753557AbcCWIWv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 04:22:51 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MVZuV-1aGpeN2Nwd-00Z2ee; Wed, 23 Mar 2016 09:22:36
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq7fguie7t.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:MUf8TIqcqWJIVNqQNYN1k5RMzLtTYuJURVjtBZJHWszFrLsVyw3
 4nh2GOnvdR7wwwdRVoU099hdytSUZk8LtMscyw/Ft5HRenGZQcV6Ku6hMK8CN6uBSjkHCOA
 C4NTb3++in2oEb0aav4pKLh/OQtlJ40xYEtIzzOd+XsAswKaXCe+xtbi6mBJSWN7HIx7HR8
 6rPNBiuJGjNqXMU5xsV5A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:74Jv8CvwlWk=:hPMp1FHSSSApxZra4BGMew
 T41cVqTspB8scjincDUpu/AGoVB1wRZwdLkvSYhPYPB16IkGEOL/D5kncuEWmF4GDvixWkgQ0
 I0b1UM3RXoQndTTC8wZsUaOT841t4wvTRnKqS+kQF0QuAR7/+z3CmMsOjD/vqhmXrf0r72+Vq
 kDYJRYdSaLYggTdE0Y3xNNNIP8G+RbYXXxRkmqF9PRGfbWFrCahD1ibS7DAazfgw9hlJZZU9t
 tp7a4D+I/MF850uCBZNJRVIYOJlOjV4IrOSucb6x67rUdgEFvD2JGvfQaGsAnfp9GFyzJXqR3
 F1r6SREYMT9h/fVkFOXh8Yn6UjKtATpIwLGPxLKW+mAOS/TCV+MNc6qPyIef4vn9TNpt2cIj9
 cHhfV+xRReFUBFCNjCxh0cLoeHqt6n5MT4FRj6xQ67ZXDYGSSeDI8BNptTt8foGcx3XJlstBF
 rxr5TkqhC0dCmJcbLVHgvdWyRoKnPFhMdIjRJ565BQQ1bWmKVAZKdWRrHeUK59Z1XPOuBy3Q0
 s0YfckpYKjtQEtQb8KuIHWrWvw83z/payejfVIvabHtx5LMFMV7dh57PVSRNDhTkWi/VR/Thl
 Tq0xvZ3C5deH5ME/JS7sV9HR386DD1c3ibQgTA961arBo504rR7y+DjRFKpxOTBTrMQk3FXa+
 iTN1JFPuXmXUt/ZWsCQQOa1nWaVvOUxZLFi4LV8b7T736ud8Jbz61TtVFgu0mn7W4EQdKuyxT
 rjcucKb4VKWqtQLZRBQOSyBuOpIB4cV16MzDeLDfwGBMVSffT+tZjuDpwxRuDqvAbzgvdCvq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289601>

Hi Junio,

On Tue, 22 Mar 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > One of this developer's primary tools to diagnose broken regression
> > tests is to run the test script using 'sh -x t... -i -v' to find out
> > *which* call *actually* demonstrates the symptom.
> >
> > Hence it is pretty counterproductive if the test script behaves
> > differently when being run via 'sh -x', in particular when using
> > test_cmp or test_i18ncmp on redirected stderr.
> >
> > So let's use grep instead of test_cmp/test_i18ncmp to verify that stderr
> > looks as expected.
> 
> In the modern world, I would probably described the problem as
> "tXXXX -i -v -x", though, not "sh -x tXXXX", but they both exhibit
> the same symptom.

Thanks for pointing me to -i -v -x. The introduction of the RHS -x somehow
slipped by me.

> I wonder if "tXXXX -i -v -x" can be made not to contaminate the
> standard error stream of the test, but that would be a larger change
> we probably would not have time for 2.8 final anyway.

Agree, both on "we want to have this" and "after 2.8".

Ciao,
Dscho
