From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC/GSoC 00/17] A barebones git-rebase in C
Date: Mon, 14 Mar 2016 21:44:44 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603142142260.4690@virtualbox>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com> <CACsJy8BmiqFJ1tN6-uAWqXMUyvGRdWP2DVfgwE56Y1K9KHCsfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 21:45:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afZMZ-0004kV-DB
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 21:45:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756115AbcCNUpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 16:45:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:50419 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741AbcCNUox (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 16:44:53 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lk8CY-1a8AHH2riU-00c77t; Mon, 14 Mar 2016 21:44:45
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CACsJy8BmiqFJ1tN6-uAWqXMUyvGRdWP2DVfgwE56Y1K9KHCsfQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:8I+lM5fbU9CRwt8/GTQ1JdQJ7mWQaI9LQx3YBzZyVlAxclDX3Jq
 +Mlfw1cXq/gPlENcUKRVlqfkVz9tmRZlFejCghUMxpCxOxcebUwK3c6afSoqafvAmb4JXAg
 agaiKFad2CkHR+bLvmjeMzHYxbzLRPqx/nVW9kkNiPRHOQhx9wfapW5zh+StzsALv86imoO
 esYutir42f07tWezy44hw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hh5xrVH0X0s=:ZhCra/39tmIZJ7RRgAWCWz
 6zV7ftQXkmQQu4OVBO9yhIUfz8eZfK319tuNXDaJUgSNseuQEvAtS5VCKq4W7rlSJP8Y/sdT+
 QtqmydU0LOqIBEzWqouDWofkUIb76mCMNac5C5ru3jOVUB996D70yaWgEiz1ItEe2uxCBa4r3
 2vf+IYreOw307VCyaXksd/QVZIxk0/7c7baDoOEX1pTdtDRN0A2KZ7aw7vo3ISfTggeGsoJmO
 nrYJHEn4nsulXyN+oItj2UbAfTg/hsdZbFDtHV7yZlCLfayiM9vGkyDY4D21IZfC9ANYFYABM
 unRpa2H/7mGzydPJthzl33M2LKH2kj7Wnr5AwCVJ6YQUE9VGkiAFocBzl+UkZA7kd5Qucsu9E
 81tnKTQxuMVoFCsf9AeKlrRf4/h0QoIeYiVdghkkWiwmuuY1vABrMMsmehRLt5xTJadr7WQH+
 2blKQ0uh8eZQZc6zjzRGouCfc2RPLKObmeA2TqaTMcQmuYs5wPW7F1f23n/BcFmpYNT3iI1si
 h5WWhW8gDfeJY897ssCfuWZflVliytSvBDFHBgzkPBB4b45w5r7oYaV8LMwxGxWZPXeM2pIlS
 b6G/6OInfQmaeTFxbAwy9SRrcLflJ7HzIyhJ1zLu5PoTQvnt9dIQbi+BUz9flWvQnSoUTT5eT
 nTSKg65ynKUYv1q98XAjvDLpeV+Y6XKhlzojsEN7OroGuK+vN+PJOQKThi6R8BP9Lmoc6il65
 owuUWLL0r9brDH/NV4TZPSfuCyrczBBk5EFzxgKJEYQRg94gPwdOAe3EKEnqo88PsfbskFrl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288809>

Hi Duy,

On Mon, 14 Mar 2016, Duy Nguyen wrote:

> On Sat, Mar 12, 2016 at 5:46 PM, Paul Tan <pyokagan@gmail.com> wrote:
> 
> >  rebase-am.c                        | 110 +++++++++++
> >  rebase-am.h                        |  22 +++
> >  rebase-common.c                    | 220 ++++++++++++++++++++++
> >  rebase-common.h                    |  48 +++++
> >  rebase-interactive.c               | 375 +++++++++++++++++++++++++++++++++++++
> >  rebase-interactive.h               |  33 ++++
> >  rebase-merge.c                     | 256 +++++++++++++++++++++++++
> >  rebase-merge.h                     |  28 +++
> >  rebase-todo.c                      | 251 +++++++++++++++++++++++++
> >  rebase-todo.h                      |  55 ++++++
> 
> topdir is already very crowded. Maybe you could move all these files
> to "rebase" subdir.

Yes, I had mentioned a couple times that my preference would be to
introduce a rebase--helper builtin and move functionality into it one by
one, which is incidentally exactly what I already did in my
'interactive-rebase' branch. It still has a couple of very rough edges,
but I could not work on it today (because v2.7.3 surprised me and shuffled
my tasks around, and then I hunted two bugs the entire day and have to
continue tomorrow).

Paul, may I ask you to concentrate on the parts that are *not* the
interactive rebase?

Ciao,
Johannes
