From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 81/83] apply: roll back index in case of error
Date: Mon, 2 May 2016 09:07:01 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605020906400.9313@virtualbox>
References: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org> <1461505189-16234-2-git-send-email-chriscool@tuxfamily.org> <alpine.DEB.2.20.1604251802480.2896@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 02 09:07:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ax7x4-0002m4-K8
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 09:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146AbcEBHHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 03:07:21 -0400
Received: from mout.gmx.net ([212.227.15.15]:52743 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753094AbcEBHHT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 03:07:19 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MHoWj-1ayUSU3SVp-003bkB; Mon, 02 May 2016 09:07:00
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <alpine.DEB.2.20.1604251802480.2896@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:UxI0WBixO9STIAXHZCv5P1ajv6vxUaTc7RVVD2nZYKCM60O+J13
 VC1yj81EtPOlNjRzhf4JRDU8o9tl/VZ2OKJ2EKYxyfcRYl9apWL8dEoa66jvRQSEmWj5Itb
 LJFe/byLdI3Wk61TfTrSEvXjFuSzF8q9pmeTeEJDhieEEWAyJK40tCpcqRVNPnUagAMISCO
 IMV6kVLXEMVDsnWUj9F+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a2wP+KDvRKQ=:AlS716f/IySt9Hbar41rPT
 UrrGE/GN7PgqGe0kq640SBgVCTBe8ByzRwvoKBuXM0bVpZ5pKYN1VxsR3xsET4Q5zxIn8tgwN
 K6soXP5PWeD7UFytXsw72nqVpZemaDzSXA09XzA8x1D7ACwGKIeh7PimWbaeTvTUPSUSe254b
 33djIWiimy79ijuV6qaQbOTEoxiJIO3JZc7B6/WfPyO1VdDQF0SzD627C06J96FIGByEaX7ML
 CrK2WWdtCsYKzMug+kqmfOAhnbqqRigbw7HGQ1vMyG73rY4gHDVSmry9Bo5oC9fcLYed5+EhO
 YkhwZ20PFbk9fNAsAjI3KA91VivsD81PSdrAimGQXmBOxv/Cx6q62t+kR5AXk/1e4qS2oTfy9
 9uz0bGmbkUDPllspkc8PZJ0fWGGoWX6hgfnIOGjxZ0Fbx/mAvavWg/gAnJ8oLwwUNnqMkgNZV
 NY97xbxtqToEJyGP/an76pLHBpYSqwW2FEfwbGe7TYEsidIwsf+ZPcOy3iIKENUHyDWk33LuK
 y+CjFH9wbUTMSMENKmMyw/APizpSyyXwS9OWbgV/X8iczzN/o2MLBsbmO0Gbo9dzAA2vnUKyu
 Vq2dArGtdbmich2t0Wq1Eg8Bo+MkHJ8nlidff4lPBFLfJ+QR2+AlOkeElvjGiNfkH0whaTtVv
 4jMFgOROdMFiGP6LIUupw7iI82IMvPJPriXC29c/RNK2UE63Uj99sdYBNuX7q55CfGZBQkPX8
 2Pglxt5/uLFOvOQQOcEu6lx9RK9GxEU+MSWKHafY+ENNnwfIIsbnHMGQMjfsvhV52UsRPc5F 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293222>

Hi,

apparently this mail never made it to the list???

On Mon, 25 Apr 2016, Johannes Schindelin wrote:

> Hi Chris,
> 
> On Sun, 24 Apr 2016, Christian Couder wrote:
> 
> > @@ -4734,16 +4737,22 @@ int apply_all_patches(struct apply_state *state,
> >  		read_stdin = 0;
> >  		set_default_whitespace_mode(state);
> >  		res = apply_patch(state, fd, arg, options);
> > -		if (res < 0)
> > +		if (res < 0) {
> > +			if (state->lock_file)
> > +				rollback_lock_file(state->lock_file);
> >  			return -1;
> > +		}
> >  		errs |= res;
> >  		close(fd);
> 
> In case of error, this leaves fd open, which in the end will prevent the
> "patch" file, and hence the "rebase-apply/" directory from being removed
> on Windows. This triggered a failure of t4014 here (and possibly more, but
> it took me quite a while to track this down, what with builtin/am.c's
> am_destroy() not bothering at all to check the return value of
> remove_dir_recursively(), resulting in the error to be caught only much,
> much later).
> 
> Could you please review all open()/close() and fopen()/fclose() calls in
> your patch series, to make sure that there are no mistakes? A passing test
> suite does not really make me confident here, as our code coverage is not
> quite 100%.
> 
> Thanks,
> Dscho
> 
