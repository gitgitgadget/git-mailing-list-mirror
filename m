From: Michael G Schwern <schwern@pobox.com>
Subject: Re: [PATCH 7/7] Make Git::SVN and Git::SVN::Ra canonicalize paths
 and urls.
Date: Sat, 28 Jul 2012 12:15:36 -0700
Message-ID: <50143A58.5050600@pobox.com>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-8-git-send-email-schwern@pobox.com>
 <20120728141126.GD9715@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 21:16:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvCUu-0002IL-TX
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 21:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069Ab2G1TPi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Jul 2012 15:15:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41681 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753004Ab2G1TPh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jul 2012 15:15:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E5AA8FC6;
	Sat, 28 Jul 2012 15:15:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=q5JZKGzO7MGl
	L84+9nyJw8FOidk=; b=AIJ+2Qmql0LYU3VXvnfW1CJeI5jm6B3NRzE1QfUVSiRC
	PG7W3jLIDePOydpYSDJI5FULbVT+WbuQ61RoR0oLRBtkxaQ7Bj+RMMtdlpwDBu6P
	WfwY7rqJWacTP0BnNMLb/BiesLHYaPEerfV+dvSZtHRihjzTqLzd8ImkkBRsTf0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=IZ2M5j
	p/x9PFbB3Wt3WYl8+HkFla0bFOswTZNis2MTXn2yRl8WhvzDHvzhyNe9FHxqBoUp
	o8dx0RYaGAcBD6vd/8PlTIoCecqDXCht0bvfcgTPPv0L+reO6CV6dNJbhs6iX+dp
	AT3nYyQPGQfgsEIVNrg3r7c6EJwhTOKU7uWs0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A4EA8FC4;
	Sat, 28 Jul 2012 15:15:37 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7EBE08FC3; Sat, 28 Jul
 2012 15:15:36 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120728141126.GD9715@burratino>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: 9CAD19D4-D8E8-11E1-8537-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202457>

On 2012.7.28 7:11 AM, Jonathan Nieder wrote:
> Yay!  Am I correct in imagining this makes the following sequence of
> commands[1] no longer trip an assertion failure in svn_path_join[2]
> with SVN 1.6?
>=20
> 	git svn init -Thttp://trac-hacks.org/svn/tagsplugin/trunk \
> 		-thttp://trac-hacks.org/svn/tagsplugin/tags \
> 		-bhttp://trac-hacks.org/svn/tagsplugin/branches
> 	git svn fetch

Works For Me=99!

  ...
  Checked out HEAD:
    http://trac-hacks.org/svn/tagsplugin/trunk r11776


--=20
Insulting our readers is part of our business model.
        http://somethingpositive.net/sp07122005.shtml
