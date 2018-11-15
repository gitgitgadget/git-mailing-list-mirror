Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 513371F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 12:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbeKOWiD (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 17:38:03 -0500
Received: from mout.gmx.net ([212.227.17.22]:36921 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728801AbeKOWiD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 17:38:03 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MbKXI-1g4Uuh1JCO-00IlRM; Thu, 15
 Nov 2018 13:30:15 +0100
Date:   Thu, 15 Nov 2018 13:29:58 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/5] tests: respect GIT_TEST_INSTALLED when initializing
 repositories
In-Reply-To: <20181114213851.GA2960@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1811151329150.41@tvgsbejvaqbjf.bet>
References: <pull.73.git.gitgitgadget@gmail.com> <948b3dc146fe353fbab6057c1376fa0e787a444f.1542030510.git.gitgitgadget@gmail.com> <xmqqin10p8aq.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1811141413170.39@tvgsbejvaqbjf.bet>
 <20181114213851.GA2960@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rIIxVx9aAA0Y69N84TTe6wObRVvg0Sj3BVP1w0Aj6/FDyYkbKlQ
 Xna/n1NN/XfX/I4UtnG5Faz8hzUAYKPzLXjZ71O/5hr+wEPeI8RjTGoSaU7X4WraLBf53re
 igU6xQCViWj61e2WjpGsgZmrYRSvEcuvru8tX+oILqbnMzd8dHQHKiP5a2zgheS86JUaWHz
 kdAFfiyK7KvqOxnHZgURw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:czLOnhHsHU8=:j7K2AJ0Iv23ormUtpqGD3a
 j7t8lAvOX96X0sQfc/OWKosMoh3NyynCaWw4tP6grzG5JYYDSlz3B2eWGNgYmnXKiAmbyc7/L
 u+pZrtY60e3h+q5Kd5jq8RayZK/yDwSSLaKffRTpKmyTZehhlvkFhu+7btM9wM/Rg/o6HCCvf
 Yc2+PWa+hTr1lioAjfAKoai3TZrit6LJ2L7gGupJpRuT6PwXx5xJ+RksAO3cMrrJYQExHhfbt
 hbPZmK1GtQR2B51qiBwBgxu+DpeYMMjskK9ZBUfd1xxzjN/1Gph41UTKp/YB7+ljVrz9tT0eB
 KMygq89BHP69EAxjBxRFA2oDey52LwNv7CpLgKqofsRi01obp9zFaY5HIR0/q7cG3SavN0krI
 jhZWFtA4IE2sA157JfPoRP0PQPX4iiiTKxmk7+6O5IpLDgmWqkfGr18u9Q3l+5lIwykes6GcG
 M1cZ4Ob3Zeyfaa7eP4jGb5hRuV4Vuf/t089Xh2zYTyCtLiiGTRwArPffdXJ0LooPmNVrQQByF
 RLp9E+8CFidYJK7iEJ5XTpIhbJcE6qhJFoyC/4dMUnxCNe43T4++HEIJYPdfUzyjJcyVyq6zl
 TDzmDllXaUD62QZCY56MpDZYDNbHoQfbZ7TQ8H28/Mn0bPTVXJJ95oZAlmxjR+lOf6cX15CwZ
 wl/fKFUby/lHddgmLziwBgODlpaKPoUnnJx02kSqbNAfjr/0psLTtT5Bo5acS1h+g6FDjs3pJ
 Y6mnS35nUbJ5bK+/oa2JbuudWucIwBPs+BbDeZdj9m2BtyACZDftcOAGYvyIkXV+dHHF6BYB7
 MmILUmSM2UaAiYpiEOR7xcU/hEKRcJHgB+hlpVMZT0CzwiqxUYJ7OUx1kBbKiYZPrJtIzeFW9
 SSLGLcHHU590+brF/UBtZ9zgNs3uBsiqQVu6MIXeEBJoh6rheXYexFroRwZyc85nR2sMMJdW0
 Xw1CDn0APcQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 14 Nov 2018, Jeff King wrote:

> On Wed, Nov 14, 2018 at 02:16:37PM +0100, Johannes Schindelin wrote:
> 
> > > Makes perfect sense.  Shouldn't we be asking where the template
> > > directory of the installed version is and using it instead of the
> > > freshly built one, no?
> > 
> > It would make sense, but we don't know how to get that information, do we?
> > 
> > $ git grep DEFAULT_GIT_TEMPLATE_DIR
> > Makefile:       -DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"'
> > builtin/init-db.c:#ifndef DEFAULT_GIT_TEMPLATE_DIR
> > builtin/init-db.c:#define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
> > builtin/init-db.c:              template_dir = to_free = system_path(DEFAULT_GIT_TEMPLATE_DIR);
> > contrib/vscode/init.sh: '-DDEFAULT_GIT_TEMPLATE_DIR="$(template_dir_SQ)"' \
> > 
> > In other words, the Makefile defines the DEFAULT_GIT_TEMPLATE_DIR, and the
> > only user in the code is init-db.c which uses it in copy_templates().
> > 
> > And changing the code *now* to let us query Git where it thinks its
> > templates should be won't work, as this patch is about using the installed
> > Git (at whatever pre-compiled version that might be).
> 
> Do we actually care where the templates are? I thought the point was to
> override for the built Git to use the built templates instead of the
> installed one. For an installed Git, shouldn't we not be overriding the
> templates at all? I.e.:
> 
>   if test -n "$GIT_TEST_INSTALLED"
>   then
> 	"$GIT_TEST_INSTALLED/git" init
>   else
> 	"$GIT_ExEC_PATH/git" init --template="$GIT_BUILD_DIR/templates/blt"
>   fi >&3 2>&4
> 
> (That's all leaving aside the question of whether we ought to be using a
> clean template dir instead of this).

I fear that that might buy us a ton of trouble. Just like we override the
system config, we should override the templates.

Ciao,
Dscho
