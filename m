From: Joel Kaasinen <joel@zenrobotics.com>
Subject: [BUG] git bisect start fails when stale bisect data is left behind
Date: Mon, 5 Sep 2011 14:15:34 +0300
Message-ID: <CAC6WLetwT9UvBY_=Nf38hhkyU1mhmdWHWqscf3ebba1WRGS1LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 13:15:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0X9R-0006wY-Qh
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 13:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514Ab1IELPg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Sep 2011 07:15:36 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64740 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274Ab1IELPf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Sep 2011 07:15:35 -0400
Received: by iabu26 with SMTP id u26so6241820iab.19
        for <git@vger.kernel.org>; Mon, 05 Sep 2011 04:15:34 -0700 (PDT)
Received: by 10.231.67.80 with SMTP id q16mr7235101ibi.86.1315221334431; Mon,
 05 Sep 2011 04:15:34 -0700 (PDT)
Received: by 10.231.192.149 with HTTP; Mon, 5 Sep 2011 04:15:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180733>

Hi,

Just bumped into a weird bug: bisect refused to start. It seems some
previous bisect had left around state that referred to a
now-nonexistent branch.

How to reproduce:
$ echo foo > .git/BISECT_START
$ git bisect start HEAD HEAD^

=46ails with "fatal: invalid reference:" on git 1.7.6.

=96J

PS. Please CC me when answering, I'm not subscribed
