From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 2/2] transport-helper: ask the helper to set the same
 options for import as for fetch
Date: Sat, 14 Feb 2015 07:14:50 +0900
Message-ID: <20150213221450.GA24285@glandium.org>
References: <xmqqlhk2ri1j.fsf@gitster.dls.corp.google.com>
 <1423805086-807-1-git-send-email-mh@glandium.org>
 <1423805086-807-2-git-send-email-mh@glandium.org>
 <xmqqwq3lmwnb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 23:15:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMOVv-0004IB-Cu
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 23:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403AbbBMWPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 17:15:00 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:34967 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752743AbbBMWPA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 17:15:00 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YMOVe-0006Lp-U0; Sat, 14 Feb 2015 07:14:50 +0900
Content-Disposition: inline
In-Reply-To: <xmqqwq3lmwnb.fsf@gitster.dls.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263844>

On Fri, Feb 13, 2015 at 11:36:24AM -0800, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > A remote helper is currently only told about the 'check-connectivity',
> > 'cloning', and 'update-shallow' options when it supports the 'fetch'
> > command, but not when it supports 'import' instead.
> 
> Sounds sensible.
> 
> Does the same issue exist for export vs push or do they happen to be
> coded to pass similar enough set of options already by copied and
> pasted code?

The issue exists:
- export is given dry-run, pushcert and force.
- push is given cas, dry-run and pushcert.

(note: cas and pushcert are both not documented in
gitremote-helpers.txt)

Force is actually not necessary for push, because the push syntax itself
includes the force instruction in the refspec given as argument.

I haven't looked exactly what cas does and if it makes sense for export.
(FWIW, I'm using push and import at the moment, so it's not a direct
issue for me ; I don't support cas anyways)

Mike
