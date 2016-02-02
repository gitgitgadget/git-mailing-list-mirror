From: Mike Hommey <mh@glandium.org>
Subject: Re: parse_object does check_sha1_signature but not
 parse_object_buffer?
Date: Tue, 2 Feb 2016 13:36:28 +0900
Message-ID: <20160202043628.GA10253@glandium.org>
References: <20160202015701.GA30444@glandium.org>
 <xmqq60y7u7sj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 05:36:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQShl-0007Wj-P5
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 05:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbcBBEgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 23:36:38 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:41470 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752718AbcBBEgh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 23:36:37 -0500
Received: from glandium by zenigata with local (Exim 4.86)
	(envelope-from <mh@glandium.org>)
	id 1aQShY-0002iJ-Tt; Tue, 02 Feb 2016 13:36:28 +0900
Content-Disposition: inline
In-Reply-To: <xmqq60y7u7sj.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285237>

On Mon, Feb 01, 2016 at 07:10:04PM -0800, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > Shouldn't parse_object_buffer also do check_sha1_signature?
> 
> In general, it shouldn't; its callers are supposed to do it as
> additional check when/if needed.  Callers like the one in fsck.c
> does not want to die after seeing one bad one.  We want to report
> and keep checking other things.

Shouldn't some things like, at least, `git checkout`, still check
the sha1s, though?

Mike
